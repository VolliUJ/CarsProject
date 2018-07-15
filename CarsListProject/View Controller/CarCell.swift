//
//  CarCell.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var model: UILabel!
    
    
    var viewModel : ViewModel! {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateUI(){
//        id.text = viewModel.id
        name.text = viewModel.name
        model.text = viewModel.model
    }
}
