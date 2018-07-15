//
//  File.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CarModel {
    var id : String?
    var name : String?
    var brand : String?
    var model : String?
    var year : Int?
    
    private struct CarKeys{
        static let id = "_id"
        static let name = "name"
        static let brand = "brand"
        static let model = "model"
        static let year = "year"
    }
    
    init(){
        id = nil
        name = nil
        brand = nil
        model = nil
        year = nil
    }

    init(json : JSON) {
        print(json)
        id = json[CarKeys.id].string
        name = json[CarKeys.name].string
        brand = json[CarKeys.brand].string
        model = json[CarKeys.model].string
        year = json[CarKeys.year].int
    }
}

extension CarModel {
    
    func toData() -> Data? {
        let json: [String: Any] =
            [CarKeys.name: name as Any,
             CarKeys.brand: brand as Any,
             CarKeys.model: model as Any,
             CarKeys.year: year as Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return jsonData
    }
    
    func toJSON() -> JSON {
        
        var json = JSON()
        json[CarKeys.id].string = id
        json[CarKeys.name].string = name
        json[CarKeys.brand].string = brand
        json[CarKeys.model].string = model
        json[CarKeys.year].int = year
        
        return json
    }
    
}
