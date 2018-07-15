//
//  CarListVC.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CarListVC: UITableViewController {

    var viewModel : CarListViewModel!
    var loadingView : NVActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "car_cell")
        initFrame()
        
        viewModel = CarListViewModel()
        
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
                self.stopAnimating()
                self.showErrorDialog(message: message)
                break
                
            case .normal:
                self.stopAnimating()
                break
            }
        }
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


}

extension CarListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CarDetailsVC {
            let id = tableView.indexPathForSelectedRow?.item
            viewController.viewModel = CarDetailsVC.ViewModel(carModel: viewModel.getCar(id: id!)!)
        }
    }
    
    @IBAction func unwindToCarList(segue:UIStoryboardSegue) {
        
    }
}

private extension CarListVC {
    
    func initFrame(){
        let frame = loadingFrame(width: 100.0, height: 100.0)
        loadingView = NVActivityIndicatorView(frame: frame, type: nil, color: UIColor.lightGray, padding: 3.0)
        tableView.addSubview(loadingView)
    }
    
    func loadingFrame(width : CGFloat, height : CGFloat) -> CGRect{
        let x = tableView.center.x - width / 2
        let y = tableView.center.y - height / 2
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func startAnimating(){
        loadingView.startAnimating()
    }
    
    func stopAnimating(){
        loadingView.stopAnimating()
    }
}
