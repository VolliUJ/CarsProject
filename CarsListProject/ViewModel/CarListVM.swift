//
//  CarListViewModel.swift
//  CarsListProject
//
//  Created by MGOLLI on 14.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class CarListViewModel {
    
    var state : Box<State> = Box(State.normal)
    var model : Box<Array<CarModel>> = Box([])
    
    let numberOfSections = 1
    
    var numberOfRows : Int {
        return model.value.count
    }
    
    init() {
        Alamofire.request(ApiClient.getCars()).responseData { responseData in
            switch responseData.result {
            case .success:

                guard let data = responseData.data, let json = try? JSON(data: data) else {
                    return
                }
                
                var cars : [CarModel] = []
                
                for j in json.arrayValue {
                    let car = CarModel(json: j)
                    cars.append(car)
                }
                
                self.model.value = cars
                
                break
            case .failure(let error):
                print(error)
                
                break
            }
        }
    }
    
    func getCarsList() -> [CarModel]{
        return model.value
    }
    
    func getCar(id : Int) -> CarModel? {
        return model.value[id]
    }
    
    func setCar(_ car : CarModel){
        model.value.append(car)
    }
    
}
