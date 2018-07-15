//
//  AddCarVC.swift
//  CarsListProject
//
//  Created by MGOLLI on 14.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AddCarVC : UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    private let unwindSegueIdentifier = "addCarUnwindSegue"
    let viewModel = ViewModel()
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var year: UITextField!
    
    @IBAction func save(_ sender: Any) {
        self.view.endEditing(true)
        name.style()
        brand.style()
        model.style()
        year.style()
        viewModel.save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        brand.delegate = self
        model.delegate = self
        year.delegate = self

        viewModel.name.bind{
            self.header.text = "New Car : \($0.unwrap())"
            self.name.text = $0
        }
        
        viewModel.brand.bind{
            self.brand.text = $0
        }
        
        viewModel.model.bind{
            self.model.text = $0
        }
        
        viewModel.year.bind{
            self.year.text = $0
        }
        
        viewModel.state.bind {
            switch $0 {
            case .completed:
                self.stopAnimating()
                self.performSegue(withIdentifier: self.unwindSegueIdentifier, sender: self)
                break
                
            case .networking:
                self.startAnimating()
                break
                
            case .error(let message):
                self.showErrorDialog(message: message)
                self.stopAnimating()
                
                break
                
            case .normal:
                self.stopAnimating()
                break
            }
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        if let carsVC = unwindSegue.destination as? CarListVC {
            carsVC.viewModel.setCar(self.viewModel.carModel)
        }
    }
    
}

extension AddCarVC {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.style()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let replacedNSString = NSString(string: textField.text.unwrap())
        let replacedString = replacedNSString.replacingCharacters(in: range, with: string)
        
        print(replacedString)
        textField.style(replacedString)
        
        switch textField {
        case name:
            viewModel.update(name: replacedString)
            
        case brand:
            viewModel.update(brand: replacedString)
            
        case model:
            viewModel.update(model: replacedString)
            
        case year:
            viewModel.update(year: replacedString)
        default:
            break
        }
        
        return false
    }
    
}

private extension AddCarVC {
    func showErrorDialog(message : String){
        let alert =  UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

private extension UITextField {
    
    func style(){
        style(self.text.unwrap())
    }
    
    func style(_ string : String){
        if string.isEmpty {
            self.backgroundColor = UIColor.red
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
}
