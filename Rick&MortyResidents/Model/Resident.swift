//
//  Resident.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation

struct Resident:Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Dictionary<String,String>
    var location:Dictionary<String,String>
    var image: String
    var episode: Array<String>
    var url: String
    var created: String
}

/**
 
 "id": 38,
 "name": "Beth Smith",
 "status": "Alive",
 "species": "Human",
 "type": "",
 "gender": "Female",
 "origin": {
 "name": "Earth (C-137)",
 "url": "https://rickandmortyapi.com/api/location/1"
 },
 "location": {
 "name": "Earth (C-137)",
 "url": "https://rickandmortyapi.com/api/location/1"
 },
 "image": "https://rickandmortyapi.com/api/character/avatar/38.jpeg",
 "episode": [
 "https://rickandmortyapi.com/api/episode/1",
 "https://rickandmortyapi.com/api/episode/2",
 "https://rickandmortyapi.com/api/episode/3",
 "https://rickandmortyapi.com/api/episode/4",
 "https://rickandmortyapi.com/api/episode/5",
 "https://rickandmortyapi.com/api/episode/6",
 "https://rickandmortyapi.com/api/episode/22"
 ],
 "url": "https://rickandmortyapi.com/api/character/38",
 "created": "2017-11-05T09:48:44.230Z"
 
 */
