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
    let id : String
    let name : String
    let brand : String
    let model : String
    let year : Int
    
    init?(data : Data) {
        guard let json = try? JSON(data: data) else {
            return nil
        }
        
        id = json["_id"].string ?? ""
        name = json["name"].string ?? ""
        brand = json["brand"].string ?? ""
        model = json["model"].string ?? ""
        year = json["year"].int ?? 0
    }
}
