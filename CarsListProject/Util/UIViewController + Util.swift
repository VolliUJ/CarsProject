//
//  UIViewController + Util.swift
//  CarsListProject
//
//  Created by MGOLLI on 15.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorDialog(message : String){
        let alert =  UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
