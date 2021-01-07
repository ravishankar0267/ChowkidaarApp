//
//  BaseViewController.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit

class BaseViewController: UIViewController {

    // Activity Indicator
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var meassagelabel:UILabel = UILabel()
    // Navigation
    var customHomeNavigationView: HomeNavigationBarView?
    var customNavigationView: NavigationBarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customHomeNavigationView?.removeFromSuperview()
        customHomeNavigationView = nil
        customNavigationView?.removeFromSuperview()
        customNavigationView = nil
    }
    
    func addHomeNavigationBar() {
        if customHomeNavigationView != nil{
            customHomeNavigationView?.removeFromSuperview()
            customNavigationView?.removeFromSuperview()
        }
        setupDefaultNavigationBar()
        customHomeNavigationView = Bundle.main.loadNibNamed("HomeNavigationBarView", owner: self, options: nil)?.first as? HomeNavigationBarView
        customHomeNavigationView?.baseControllerObj = self
        print(CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        customHomeNavigationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        navigationController?.navigationBar.addSubview(customHomeNavigationView!)
    }
    
    func addNavigationBar(navigationTitle: String) {
        if customNavigationView != nil{
            customHomeNavigationView?.removeFromSuperview()
            customNavigationView?.removeFromSuperview()
        }
        setupDefaultNavigationBar()
        customNavigationView = Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)?.first as? NavigationBarView
        customNavigationView?.baseControllerObj = self
        customNavigationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        navigationController?.navigationBar.addSubview(customNavigationView!)
        customNavigationView?.setNavigtionTitle(title: navigationTitle)
    }
    
    func setupDefaultNavigationBar () {
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavigationBarImage.png")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func handleMenuButtonAction() -> Void {
        // Don't implement any logic here overrride this function in your class
    }
    
    func handleNotificationButtonAction() -> Void {
        // Don't implement any logic here overrride this function in your class
    }
    
    func handleBackButtonAction() -> Void {
        // Don't implement any logic here overrride this function in your class
    }
    
    // MARK:- Activity indicator
    
    func showActivityIndicator(sMessage:String) {
        DispatchQueue.main.async {
            self.container.frame = self.view.frame
            self.container.center = self.view.center
            self.container.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.3)
            self.container.isHidden = false
            self.loadingView.frame = CGRect(x: (self.view.frame.size.width-150)/2, y: (self.view.frame.size.height-150)/2-50, width: 150, height: 150)
            print(self.loadingView.center)
            self.loadingView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.activityIndicator.frame = CGRect(x: 0.0,y:  10.0,width : 40.0, height : 40.0);
            self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            self.activityIndicator.center = CGPoint(x: self.loadingView.frame.size.width / 2, y: self.loadingView.frame.size.height / 2)
            
            self.meassagelabel.frame = CGRect(x: 0.0,y : 100.0,width : 150.0,height : 45.0)
            self.meassagelabel.text = sMessage
            self.meassagelabel.textAlignment = .center
            self.meassagelabel.textColor = UIColor.white
            self.meassagelabel.backgroundColor = UIColor.clear
            self.loadingView.addSubview(self.meassagelabel)
            self.loadingView.addSubview(self.activityIndicator)
            self.container.addSubview(self.loadingView)
            APP_DEL.window?.addSubview(self.container)
            self.activityIndicator.startAnimating()
            print(self.loadingView.frame)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
