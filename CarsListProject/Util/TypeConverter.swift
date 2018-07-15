//
//  String + Utils.swift
//  CarsListProject
//
//  Created by MGOLLI on 15.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Int {
    func toString() -> String {
        return self != nil ? "\(self!)" : ""
    }
}

extension Optional where Wrapped == String {
    func toInt() -> Int? {
        return self != nil ? Int(self!) : nil
    }
    
    func unwrap() -> String {
        guard let result = self else {
            return ""
        }
        
        return result
    }
}
