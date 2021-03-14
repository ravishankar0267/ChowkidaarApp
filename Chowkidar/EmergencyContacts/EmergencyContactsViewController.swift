//
//  EmergencyViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 2/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class EmergencyContactsViewController: BaseViewController {
    @IBOutlet weak var emergencyTableView: UITableView!
    var hospitalModel:NSMutableArray?
    var policeStationModel:NSMutableArray?
    var ambulanceModel:NSMutableArray?
    var emergencyModel:EmergencyContactsDataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatasource()
        emergencyTableView.register(UINib(nibName: EmergencyContactsTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: EmergencyContactsTableViewCell.identifier())
              
//                emergencyTableView.rowHeight = UITableView.automaticDimension
//               emergencyTableView.estimatedRowHeight = 100
        emergencyTableView.delegate = self
        emergencyTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func createDatasource()  {
        let hopitalData1 = EmergencyContactsDataModel(nameText: "Appolo hospitals", mobileNumber: "9887254162")
        let hopitalData2 = EmergencyContactsDataModel(nameText: "Appolo hospitals", mobileNumber: "9887254162")
        hospitalModel = NSMutableArray()
        hospitalModel?.add(hopitalData1)
        hospitalModel?.add(hopitalData2)
         let policeStationData = EmergencyContactsDataModel(nameText: "Ashoka police station", mobileNumber: "9887254162")
        policeStationModel = NSMutableArray()
        policeStationModel?.add(policeStationData)
        
        let callAmbulanceData = EmergencyContactsDataModel(nameText: "Ambulance", mobileNumber: "9887254162")
        ambulanceModel = NSMutableArray()
        ambulanceModel?.add(callAmbulanceData)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Emergency contacts")
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
extension EmergencyContactsViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView:UIView =  UIView()
        headerView.backgroundColor = .white
        let headerLabel = UILabel(frame:CGRect(x: 20, y: 20, width: 250, height: 30))
        headerLabel.font = UIFont(name: "WorkSans-SemiBold", size: CGFloat(19))
        headerLabel.textColor = UIColor(red: 231/255, green: 90/255, blue: 90/255, alpha: 1)
        headerView.addSubview(headerLabel)
        if(section == 0) {
            headerLabel.text = "HOSPITALS near you"
                   } else if(section == 1) {
            headerLabel.text = "POLICE STATION near you"
                    
                   }
        else{
            headerLabel.text = "CALL AMBULANCE"
        }
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
     return 3
    }
     
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if(section == 0) {
               return 2
           } else if(section == 1) {
               return 1
           } else {
               return 1
           }
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmergencyContactsTableViewCell.identifier(), for: indexPath) as! EmergencyContactsTableViewCell
        switch indexPath.section {
        case 0:
            emergencyModel = hospitalModel?[indexPath.row] as? EmergencyContactsDataModel
        case 1:
            emergencyModel = policeStationModel?[indexPath.row] as? EmergencyContactsDataModel
            
        case 2:
            emergencyModel = ambulanceModel?[indexPath.row] as? EmergencyContactsDataModel
            
        default:
            break
        }
        cell.setupUIData(DataModel: emergencyModel!)
       // cell.setupUIData(itemList: dashboardDataModel!.itemList[indexPath.row])
        return cell
        
    }
    
    

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90.0;//Choose your custom row height
        }
    
    
}
