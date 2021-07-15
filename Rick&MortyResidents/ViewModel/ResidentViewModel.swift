//
//  ResidentViewModel.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation

class ResidentViewModel: NSObject {
    
    var model: Resident
    
    var id: Int {
        return model.id
    }
    
    var name: String {
        return model.name
    }
    var status: String {
        return model.status
    }
    
    var statusWithEmoji: String {
        switch status {
        case "Alive":
            return "🟢 " + status
        case "Dead":
            return "💀 " + status
        default:
            return status
        }
    }
    
    var species: String {
        return model.species
    }
    
    var fullStatus: String {
        return statusWithEmoji + " - " + species
    }
    
    
    var origin: String {
        guard let originName = model.origin["name"] else {
            print("\n ⚠️ ResidentViewModel.origin: There was a problem getting origin from: \(model.origin)")
            return "unknow"
        }
        return originName
    }
    
    var location: String {
        guard let locationName = model.location["name"] else {
            print("\n ⚠️ ResidentViewModel.location: There was a problem getting name from: \(model.location)")
            return "unknow"
        }
        return locationName
    }
    
    var lastKnownLocation: String {
        return "Last known location: " + location
    }
    
    var firstSeenIn: String {
        return "First seen in: " + origin
    }
    
    var imageURLString: String {
        return model.image
    }
    
    var imageURL: URL? {
        guard let url = URL(string: imageURLString) else {
            print("\n ⚠️ ResidentViewModel.imageURLString: There was a problem getting URL from: \(imageURLString)")
            return nil
        }
        return url
    }
        
    init(model:Resident) {
        self.model = model
    }
    
    public func updateNote(with text:String, completion: @escaping (Note)->Void ){
        let note = Note(id: 1, userId: id, body: text)
        DataSource.createNote(with: note) { newNote in
            guard let newNote = newNote else {
                print("\n ⚠️ ResidentViewModel.updateNote: There was a problem updateing note : \(String(describing: note))")
                completion(note)
                return
            }
            completion(newNote)
        }
    }
    
    public func loadNote(completion: @escaping (Note?)->Void ){
        DataSource.retrieveNote(id: id) {[weak self] newNote in
            guard let newNote = newNote else {
                print("\n ⚠️ ResidentViewModel.loadNote: There was a problem updateing id : \(String(describing: self?.id))")
                completion(nil)
                return
            }
            completion(newNote)
        }
    }
}

