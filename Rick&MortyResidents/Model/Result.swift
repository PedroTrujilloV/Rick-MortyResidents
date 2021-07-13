//
//  Result.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation

struct Result: Codable {
    var info: Info
    var results: Array<Location>
    
    public struct Info: Codable {
        var count: Int
        var pages: Int
        var next: String?
        var prev: String?
    }

}


/**
 "count": 108,
 "pages": 6,
 "next": "https://rickandmortyapi.com/api/location?page=2",
 "prev": null
 */
