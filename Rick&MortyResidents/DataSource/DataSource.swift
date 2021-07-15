//
//  DataSource.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation
import Combine


protocol DataSourceDelegate:AnyObject {
    func dataSourceDidLoad(dataSource:Array<LocationViewModel>)
}

class DataSource {
    
    private let urlString:String = "https://rickandmortyapi.com/api/location"
    private let urlProcessingQueue = DispatchQueue(label: "urlProcessingQueue")
    private var _currentResult:Result?
    public var next:String {
        get{
            return currentResult?.info.next ?? "none"
        }
    }
    public var totalItems: Int {
        get {
            return currentResult?.info.count ?? 0
        }
    }
    public var currentResult:Result? {
        get {
            return _currentResult
        }
    }
    private var cancellable: AnyCancellable?
    private weak var delegate:DataSourceDelegate?
    private var dataSourceList:Array<LocationViewModel> = []
    private static var _locations:Dictionary<String,Location> = [:]
    private static var _residents:Dictionary<String,Resident> = [:]
    private static var _imageDataStore:Dictionary<String,Data> = [:]

    
    init(delegate:DataSourceDelegate) {
        guard let url = URL(string: urlString) else {print("\n ⚠️ DataSource.init(): There was a problem getting URL from: \(urlString)"); return}
        load(url: url)
        self.delegate = delegate
    }
    
    public func loadNext(){
        guard let nextString = currentResult?.info.next else { print("\n ⚠️ DataSource.loadNext(): There was a problem getting string from: currentResult.next "); return }
        guard let url = URL(string: nextString) else { print("\n ⚠️ DataSource.loadNext(): There was a problem getting URL from: \(nextString)"); return }
        self.load(url: url)
    }
    
    private func load(url:URL) {
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: urlProcessingQueue)
            .receive(on:DispatchQueue.main)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                return element.data
            }
            .decode(type: Result.self, decoder: JSONDecoder() )
            .eraseToAnyPublisher()
            .sink(receiveCompletion: {completion in
                print("Received completion: \(completion).")
                switch completion {
                case .finished:
                    print("JSON loaded!")
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { [weak self]  result in
                DispatchQueue.main.async { [weak self] in
                    self?.processResult(result:result)
                }
            })
        
        self.cancellable?.cancel()
    }
    
    private func processResult(result:Result){
        _currentResult = result
        self.cacheLocation(result: result)
        let results = result.results.map({LocationViewModel(model: $0)})
        self.dataSourceList.append(contentsOf: results)
        self.delegate?.dataSourceDidLoad(dataSource: self.dataSourceList)
    }
    
    private func cacheLocation(result:Result){
        DataSource._locations = result.results.reduce(Dictionary<String,Location>()) { (dict,location) -> Dictionary<String,Location> in
            var dict = dict
            dict[location.url] = location
            return dict
        }
    }
    
    public static func retrieveLocation(with urlString:String, completion: @escaping (Location?)->Void){
        guard let location = DataSource._locations[urlString] else {
            let completionHandler: (Location?)->Void = { location in
                guard let location = location else {
                    print("\n ⚠️ DataSource.retrieveLocation() completionHandler: There was a problem instancing location ")
                    completion(nil)
                    return
                }
                DataSource._locations[urlString] = location
                completion(location)
            }
            DataSource.retrieve(with: urlString, completion: completionHandler)
            return
        }
        completion(location)
    }
    
    public static func retrieveResident(with urlString:String, completion: @escaping (Resident?)->Void){
        guard let resident = DataSource._residents[urlString] else {
            let completionHandler: (Resident?)->Void = { resident in
                guard let resident = resident else {
                    print("\n ⚠️ DataSource.retrieveResident() completionHandler: There was a problem instancing resident ")
                    completion(nil)
                    return
                }
                DataSource._residents[urlString] = resident
                completion(resident)
            }
            DataSource.retrieve(with: urlString, completion: completionHandler)
            return
        }
        completion(resident)
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    
}
