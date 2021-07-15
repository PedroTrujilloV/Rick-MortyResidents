//
//  Encodable+DictionaryRepresentation.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/15/21.
//

import Foundation


public extension Encodable {
    var dictionaryRepresentation: Dictionary<String,Any>? {
        guard let data = try? JSONEncoder().encode(self) else {
            print("⚠️ Encodable.dictionaryRepresentation: there was a problem encoding object")
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { any in
            return any as? Dictionary<String,Any>
        }
    }
    
    var stringHTTPPostRepresentation: String {
        guard let dictionary = self.dictionaryRepresentation else {
            print("⚠️ Encodable.stringHTTPPostRepresentation: there was a problem getting dictionary")
            return ""
        }
        let keys = dictionary.keys
        var postString = ""
        for key in keys {
            var field = ""
            if postString != "" {
                postString += "&"
            }
            if let stringValue = dictionary[key] as? String {
                field = "\(key)='\(stringValue)'"
            } else if let numbValue = dictionary[key] {
                field = "\(key)=\(numbValue)"
            }
            postString += field

        }
        return postString != "?" ? postString : ""
    }
}
