//
//  DataSource+Typicode.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/15/21.
//

import Foundation
import Combine

extension DataSource {
    public static func createNote(with note:Note, completion: @escaping (Note?) -> Void ) {
        guard let bodyParametersJSON  = note.dictionaryRepresentation else {
            print("\n ⚠️ DataSource.createNote() dictionaryRepresentation: There was a problem body from note: \(note)")
            return
        }
        
        print("🟢 bodyParametersJSON: \(bodyParametersJSON)")

        guard let body = try? JSONSerialization.data(withJSONObject: bodyParametersJSON, options: []) else {
            print("\n ⚠️ DataSource.createNote() JSONSerialization: There was a problem body from: \(String(describing: bodyParametersJSON))")
            return
        }
        
        let urlString = "\(DataSource.notesBaseURLString)"
        guard let url = URL(string: urlString) else {
            print("\n ⚠️ DataSource.createNote(): There was a problem getting URL from: \(urlString)")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        DataSource.retrieveNote(request: request, completion: completion)
    }
    
    public static func retrieveNote(id:Int, completion: @escaping (Note?)->Void){
        let urlString = "\(DataSource.notesBaseURLString)/1"//\(id) // because the limitations of the https://jsonplaceholder.typicode just keep it like that for now
        guard let url = URL(string: urlString) else {
            print("\n ⚠️ DataSource.retrieveNote(): There was a problem getting URL from: \(urlString)")
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        DataSource.retrieveNote(request: request, completion: completion)
    }
    
    
    private static func retrieveNote( request:URLRequest, completion: @escaping (Note?) -> Void ){
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\n ⚠️ DataSource.retrieveNote() dataTask Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("\n ⚠️ DataSource.retrieveNote() dataTask bad response: \(String(describing: response)), data: \(String(describing: data))")
                completion(nil)
                return
            }
            guard let data = data else {
                print("\n ⚠️ DataSource.retrieveNote() dataTask data error: \(String(describing: data))");
                completion(nil)
                return
            }

            do {
                let model = try JSONDecoder().decode(Note.self, from: data)
                completion(model)
            } catch let DecodingError.dataCorrupted(context) {
                print("\n ⚠️ dataCorrupted. Context:")
                print(context)
                completion(nil)
            } catch let DecodingError.keyNotFound(key, context) {
                print("\n ⚠️ Key '\(key)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch let DecodingError.valueNotFound(value, context) {
                print("\n ⚠️ Value '\(value)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("\n ⚠️ Type '\(type)' mismatch:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch {
                print("\n ⚠️ error: ", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    // debugging purposes only
    static func dataToJSON(jsonData:Data) -> [String: Any] {
        guard let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? else {
            print("\n ⚠️ .dataFromDictionary: There was a problem converting data to string")
            return [:]
        }
        do {
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print("\n  ⚠️ .dataFromDictionary json string: \(str)")
            return dict as? [String : Any] ?? [:]
        } catch  {
            print("\n  ⚠️ .dataFromDictionary: There was a problem converting data to JSON, error: \(error)")
        }
        return [:]
    }
    
}
