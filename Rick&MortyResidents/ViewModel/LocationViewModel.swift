//
//  LocationViewModel.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation

class LocationViewModel: NSObject {
    var model: Location
    
    var id:Int {
        return model.id
    }
    
    var name:String {
        return model.name
    }
    
    var type:String {
        return model.type
    }
    
    var dimension:String {
        return model.dimension
    }
    
    var residents:Array<String> {
        return model.residents
    }
    
    var url:String {
        return model.url
    }
    
    init(model:Location) {
        self.model = model
    }
}
