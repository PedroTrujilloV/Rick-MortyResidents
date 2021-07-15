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
    
    var imageURLString: String {
        return model.image
    }
    
    var imageURL: URL? {
        guard let url = URL(string: imageURLString) else {print("\n ⚠️ ResidentViewModel.imageURLString: There was a problem getting URL from: \(imageURLString)"); return nil}
        return url
    }
        
    init(model:Resident) {
        self.model = model
    }
}
