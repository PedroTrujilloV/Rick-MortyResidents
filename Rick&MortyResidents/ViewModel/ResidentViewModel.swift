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
    
    init(model:Resident) {
        self.model = model
    }
}
