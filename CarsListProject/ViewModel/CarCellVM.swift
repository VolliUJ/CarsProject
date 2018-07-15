//
//  CarCellViewModel.swift
//  CarsListProject
//
//  Created by MGOLLI on 14.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation

extension CarCell {

    struct ViewModel {

        let carModel : CarModel
        
        var id: String {
            return carModel.id ?? ""
        }
        var name: String {
            return carModel.name ?? ""
        }
        var model: String {
            return carModel.model ?? ""
        }
        
    }

}
