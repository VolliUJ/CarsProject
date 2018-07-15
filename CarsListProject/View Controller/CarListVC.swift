//
//  CarListVC.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CarListVC: UITableViewController, NVActivityIndicatorViewable {

    let viewModel : CarListViewModel = CarListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        tableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "car_cell")
        
        viewModel.model.bind { cars in
            self.tableView.reloadData()
        }
        
        viewModel.state.bind {
            switch $0 {
            case .completed:
                self.stopAnimating()
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

    private func showErrorDialog(message : String){
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "car_cell", for: indexPath) as! CarCell
        cell.viewModel = CarCell.ViewModel(carModel: viewModel.getCar(id: indexPath.item)!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CarDetailsVC {
            let id = tableView.indexPathForSelectedRow?.item
            viewController.viewModel = CarDetailsVC.ViewModel(carModel: viewModel.getCar(id: id!)!)
        }
    }

    @IBAction func unwindToCarList(segue:UIStoryboardSegue) {
        
    }
    
}
