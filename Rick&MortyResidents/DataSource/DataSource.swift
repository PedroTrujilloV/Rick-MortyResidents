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
    private static var _categories:Dictionary<Int,String> = [:]
    private static var _equipments:Dictionary<Int,String> = [:]

    
    init(delegate:DataSourceDelegate) {
        guard let url = URL(string: urlString) else {print("\n ⚠️ DataSource.init(): There was a problem getting URL from: \(urlString)"); return}
        load(url: url)
        self.delegate = delegate
//        DataSource.retrieveCategory(nil)
//        DataSource.retrieveEquipment(nil)
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
        let results = result.results.map({LocationViewModel(model: $0)})
        self.dataSourceList.append(contentsOf: results)
        self.delegate?.dataSourceDidLoad(dataSource: self.dataSourceList)
    }
    
    public static func retrieveResident(with urlString:String, completion: @escaping (Resident?)->Void){
        DataSource.retrieve(with: urlString, completion: completion)
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    
}
