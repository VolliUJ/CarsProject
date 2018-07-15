//
//  ViewController.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit

class CarDetailsVC: UIViewController {

    @IBOutlet private weak var id: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var brand: UILabel!
    @IBOutlet private weak var model: UILabel!
    @IBOutlet private weak var year: UILabel!
    @IBOutlet weak var header: UILabel!
    
    var viewModel : ViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI(){
        id.text = viewModel.id
        name.text = viewModel.name
        brand.text = viewModel.brand
        model.text = viewModel.model
        year.text = viewModel.year
    }

}

