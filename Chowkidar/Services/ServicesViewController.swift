//
//  ServicesViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 31/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit
import RangeSeekSlider
import Alamofire

class ServicesViewController: UIViewController {
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var allServicesButton: UIButton!
    @IBOutlet weak var myHelpersButton: UIButton!
    var isAllServicesButtonSelected = true
    var serviceSettingView: ServiceSettingView?
    var allServicesModel:AllServiceModel?
    var myHelpersDataModel:AllServiceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fecthAllServiceData(isAllService: true, serviceUrl: kgetExternalComplexEmployee)
             servicesTableView.register(UINib(nibName: ServicesTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: ServicesTableViewCell.identifier())
                  servicesTableView.delegate = self
                  servicesTableView.dataSource = self
                         servicesTableView.rowHeight = UITableView.automaticDimension
                        servicesTableView.estimatedRowHeight = 300

        allServicesButton.setCornerRadiusButton(value: 5)
               allServicesButton.setBorderButton(color: UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), size: 2)
               myHelpersButton.setCornerRadiusButton(value: 5)
               myHelpersButton.setBorderButton(color: UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), size: 2)
        setupButtonUI()
        // Do any additional setup after loading the view.
    }
    
    
    func fecthAllServiceData(isAllService:Bool, serviceUrl: String)  {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        let params: [String: Any] = [
            "gender":0,
            "maxPrice":0,
            "minPrice":0,
            "serviceType":0,
            "accessId":500,
            "complexId":700,
            "flatNumber":"201",
            "userId":500,
            "wing":"A"
        ]
        
        NetworkManager.post_Request(urlService: serviceUrl, param: params, head: headers, responseType: AllServiceModel.self) { (response, statusCode) in
            if response != nil {
                print("GetAll service response  ===", response!)
                guard let responseData = response as? AllServiceModel else {
                    return
                }
                print("The response data is", responseData)
                if statusCode == 200 {
                    Loader.showToast(message: "Recieved dashboard data" ?? "Invalid message data", onView: self.view, bottomMargin: 200)
                    if(self.isAllServicesButtonSelected){ self.allServicesModel = responseData}
                    else{self.myHelpersDataModel = responseData}
                   
                    self.servicesTableView.reloadData()
                    
                } else {
                    Loader.showAlert(message: "Unable to fetch dashboard data" ?? "Invalid message data")
                }
            }
        }
    }
    
    
    func setupButtonUI(){
        servicesTableView.reloadData()
        if(isAllServicesButtonSelected){
           
            
            allServicesButton.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
            allServicesButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
            myHelpersButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                      myHelpersButton.setTitleColor(UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), for: .normal)
        }else{
            
            myHelpersButton.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
                       myHelpersButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
                       allServicesButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                                 allServicesButton.setTitleColor(UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), for: .normal)
            
        }
    }
    

    @IBAction func allServicesButtonAction(_ sender: Any) {
      
        
        if(isAllServicesButtonSelected){
                      
                  }
                  else{
                      // bookingHistoryTableView.isHidden = false
                      isAllServicesButtonSelected = true
                      setupButtonUI()
            
                  }
    }
    @IBAction func myHelperButtonAction(_ sender: UIButton) {

        if(isAllServicesButtonSelected){
                        // bookingHistoryTableView.isHidden = true
                        isAllServicesButtonSelected = false
                         setupButtonUI()
                        if let myHelperDataModel = myHelpersDataModel{
                            
                        }else{ fecthAllServiceData(isAllService: false, serviceUrl: kgetMyExternalComplexEmployee)}
                        //openSettingFilterView()
                     } else {
                         
                     }
    }
    
    func openSettingFilterView()  {
        if serviceSettingView == nil {
            serviceSettingView = Bundle.main.loadNibNamed("ServiceSettingView", owner: self, options: nil)?.first as? ServiceSettingView
            serviceSettingView?.frame = CGRect(x: 0, y: ScreenSize.SCREEN_HEIGHT, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            var blurview = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT))
            blurview.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
            self.view.addSubview(blurview)
            self.view.addSubview(serviceSettingView!)
            UIView.animate(withDuration: 0.5, animations: {
               
               
                self.serviceSettingView?.frame = CGRect(x: 0, y: ScreenSize.SCREEN_HEIGHT/2-100, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
                let slider = RangeSeekSlider()
                slider.minValue = 1500
                slider.maxValue = 20000
                slider.selectedMinValue = 2000
                slider.selectedMaxValue = 20000
                
                slider.tintColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
                slider.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH-36, height: 40)
                //slider.disableRange = true
                
                self.serviceSettingView?.setCornerRadius(value: 10)
                self.serviceSettingView?.setupLanguageButtonBorder()
                self.serviceSettingView?.lanugaeSelection = .english
                self.serviceSettingView?.serviceSelection = .cook
                self.serviceSettingView?.setLangaugeButtonState(tag: self.serviceSettingView!.lanugaeSelection.rawValue)
                self.serviceSettingView?.setServiceButtonState(tag: (self.serviceSettingView?.serviceSelection.rawValue)!)
                
                self.serviceSettingView?.SliderView.addSubview(slider)
                
               // self.view.addSubview(slider)
            }) { (true) in
//                self.serviceSettingView?.removeFromSuperview()
//                self.serviceSettingView = nil
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addorRemoveService(buttonText:String)  {
        
    }

}

extension ServicesViewController:UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(isAllServicesButtonSelected){
      return allServicesModel?.count ?? 0
    }else{return myHelpersDataModel?.count ?? 0}
   
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ServicesTableViewCell.identifier(), for: indexPath) as! ServicesTableViewCell
     cell.selectionStyle = .none
    weak var weakSelf : ServicesViewController? = self
    if(isAllServicesButtonSelected){
        let allServiceDataModel = allServicesModel![indexPath.row] as AllServiceDataModel
        cell.setupUIData(isAllServiceSelected: isAllServicesButtonSelected, allServiceDataModel: allServiceDataModel)
        cell.resetCompletionBlock = {text -> Void in
        
                   if let strongself = weakSelf
                   {
                    strongself.addorRemoveService(buttonText: text)
                   }
               }
    } else{
        let allServiceDataModel = myHelpersDataModel![indexPath.row] as AllServiceDataModel
        cell.setupUIData(isAllServiceSelected: isAllServicesButtonSelected, allServiceDataModel: allServiceDataModel)
    }
    
//    cell.callCompletionBlock = {Void -> Void in
//
//                      if let strongself = weakSelf
//                      {
//                       strongself.callServiceButton()
//                      }
//                  }
    
    return cell
    
}



    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   // openViewController(controller: BookHallsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
        
    }
}

