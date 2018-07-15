//
//  CarDetailsVM.swift
//  CarsListProject
//
//  Created by MGOLLI on 14.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation

extension CarDetailsVC {
    
    struct ViewModel {
        
        private let idStr = "ID: "
        private let nameStr = "Name: "
        private let brandStr = "Brand: "
        private let modelStr = "Model: "
        private let yearStr = "Year: "
        
        let carModel : CarModel
        
        var id: String {
            return idStr + carModel.id.unwrap()
        }
        var name: String {
            return nameStr + carModel.name.unwrap()
        }
        var model: String {
            return modelStr + carModel.model.unwrap()
        }
        
        var brand: String {
            return brandStr + carModel.brand.unwrap()
        }
        
        var year: String{
            return yearStr + carModel.year.toString()
        }
        
    }
    
}
