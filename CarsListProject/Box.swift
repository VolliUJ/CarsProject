//
//  Box.swift
//  CarsListProject
//
//  Created by MGOLLI on 12.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener : Listener?
    
    var value : T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value : T){
        self.value = value
    }
    
    func bind(listener : Listener?){
        self.listener = listener
        listener?(value)
    }
    
}
