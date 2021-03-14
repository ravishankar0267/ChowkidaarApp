//
//  MaintenanceViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 3/2/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class MaintenanceViewController: UIViewController {

    @IBOutlet weak var maintenanceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        maintenanceTableView.register(UINib(nibName: MiantenancePaidTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MiantenancePaidTableViewCell.identifier())
        
        maintenanceTableView.register(UINib(nibName: MaintenanceTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MaintenanceTableViewCell.identifier())
    
        
        maintenanceTableView.delegate = self
        maintenanceTableView.dataSource = self
        maintenanceTableView.rowHeight = UITableView.automaticDimension
        maintenanceTableView.estimatedRowHeight = 100

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MaintenanceViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row%2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MiantenancePaidTableViewCell.identifier(), for: indexPath) as! MiantenancePaidTableViewCell
           cell.setupUIData()
            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier(), for: indexPath) as! MaintenanceTableViewCell
            cell.setupUIData()
            return cell
        }
      
        
    }
    
    
    
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openViewController(controller: MaintenanceDetailViewController.self, storyBoard: .mainStoryBoard) { (vc) in
            
        }
    }
}
