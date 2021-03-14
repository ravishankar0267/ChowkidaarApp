//
//  AboutUsViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 2/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    @IBOutlet weak var aboutUsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         aboutUsTableView.register(UINib(nibName: CallusTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: CallusTableViewCell.identifier())
                      
        //                emergencyTableView.rowHeight = UITableView.automaticDimension
        //               emergencyTableView.estimatedRowHeight = 100
                aboutUsTableView.delegate = self
                aboutUsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "About us")
       // getProfileData()
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
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

extension AboutUsViewController:UITableViewDelegate,UITableViewDataSource {

    
   
     
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CallusTableViewCell.identifier(), for: indexPath) as! CallusTableViewCell
      
        cell.setupUIData()
       // cell.setupUIData(itemList: dashboardDataModel!.itemList[indexPath.row])
        return cell
        
    }
    
    

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160.0;//Choose your custom row height
        }
    
    
}

