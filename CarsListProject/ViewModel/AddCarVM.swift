//
//  AddCarVM.swift
//  CarsListProject
//
//  Created by MGOLLI on 14.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


extension AddCarVC {
    class ViewModel {
        let state = Box<State>(.normal)
        
        let name = Box<String?>("")
        let brand = Box<String?>("")
        let model = Box<String?>("")
        let year = Box<String?>("")
        
        var carModel = CarModel(){
            didSet {
                name.value = carModel.name
                brand.value = carModel.brand
                model.value = carModel.model
                year.value = carModel.year.toString()
            }
        }
    }
}

extension AddCarVC.ViewModel {
    
//    func save(){
//        let json = carModel.toJSON()
//        print(json["name"].string)
//        let raw = try! json.rawData()
//        print(raw)
//        let j = try! JSON.init(data: raw)
//        print(j)
//    }
    
    func save(){
        if !carModel.isValid() {
            return
        }
        self.state.value = State.networking
        Alamofire.request(ApiClient.create(car: carModel)).responseData { responseData in
            switch responseData.result {

            case .success:

                guard let data = responseData.data, let json = try? JSON(data: data) else {
                    let error = NSError.init(domain: "tutaj", code: 600, userInfo: [:]) as Error
                    self.onError(error: error)
                    return
                }

                self.carModel = CarModel(json: json)
                self.state.value = State.completed
                break

            case .failure(let error):
                self.onError(error: error)
                return
            }
        }
    }
    
    private func onError(error : Error){
        self.state.value = State.error("Request Error")
    }
    
}

extension AddCarVC.ViewModel {
    
    func update(name : String?){
        carModel.name = name
    }
    
    func update(brand : String?){
        carModel.brand = brand
    }
    
    func update(model : String?){
        carModel.model = model
    }
    
    func update(year : String?){
        let year = year.unwrap()
        
        if year.isEmpty {
            carModel.year = nil
        } else {
            if let yearInt = Int(year) {
                carModel.year = yearInt
            }
        }
    
    }
}

private extension CarModel {
    func isValid() -> Bool {
        
        if self.brand.unwrap().isEmpty ||
            self.model.unwrap().isEmpty ||
            self.name.unwrap().isEmpty ||
            self.year == nil {
            
            return false
        }
        return true
        
    }
}
