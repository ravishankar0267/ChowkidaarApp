//
//  BookHallsViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 25/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class BookHallsViewController: UIViewController {

    @IBOutlet weak var bookHallBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bookHallBGView: UIView!
    @IBOutlet weak var bookHallHistoryButton: UIButton!
    @IBOutlet weak var bookHallButton: UIButton!
    var isHistoryButtonSelected:Bool?
    @IBOutlet weak var bookingHistoryTableView: UITableView!
    
    @IBOutlet weak var bookHallPriceBGView: UIView!
    @IBOutlet weak var scrollBGView: UIScrollView!
    @IBOutlet weak var bookHallConfirmButton: UIButton!
    
    
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var selectHallTextField: UITextField!
    
    @IBOutlet weak var selectDateTextField: UITextField!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS){
            bookHallBottomConstraint.constant = 15
        }
        bookingHistoryTableView.register(UINib(nibName: BookHallTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: BookHallTableViewCell.identifier())
        bookingHistoryTableView.delegate = self
        bookingHistoryTableView.dataSource = self
               bookingHistoryTableView.rowHeight = UITableView.automaticDimension
              bookingHistoryTableView.estimatedRowHeight = 100
        isHistoryButtonSelected = true
        bookHallButton.setCornerRadiusButton(value: 5)
        bookHallButton.setBorderButton(color: UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), size: 2)
        bookHallHistoryButton.setCornerRadiusButton(value: 5)
        bookHallHistoryButton.setBorderButton(color: UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), size: 2)
        setupButtonUI()
        
                    let salutations = ["", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs.", "Mr.", "Ms.", "Mrs."]
                   selectHallTextField.loadDropdownData(data: salutations)
         self.selectDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDoneDate(sender:datePicker1:)))
         self.startTimeTextField.setInputViewTimePicker(target: self, selector: #selector(tapDoneStartTime(sender:timePicker:)))
        self.endTimeTextField.setInputViewTimePicker(target: self, selector: #selector(tapDoneEndTime(sender:timePicker:)))
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.bookHallPriceBGView.setCornerRadius(value: 10)
                  self.bookHallPriceBGView.backgroundColor = .white
                  self.bookHallPriceBGView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
                  self.bookHallConfirmButton.setCornerRadius(value: 5)
           

        }
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDoneDate(sender: Any, datePicker1: UIDatePicker) {
           print(datePicker1)
           if let datePicker = self.selectDateTextField.inputView as? UIDatePicker { // 2.1
               let dateformatter = DateFormatter() // 2.2
               dateformatter.dateStyle = .medium // 2.3
               self.selectDateTextField.text = dateformatter.string(from: datePicker.date) //2.4
           }
         self.view.endEditing(true)
           //self.myTextField.resignFirstResponder() // 2.5
       }
    
    @objc func tapDoneStartTime(sender: Any, timePicker: UIDatePicker) {
             print(timePicker)
             if let timePickr = self.startTimeTextField.inputView as? UIDatePicker { // 2.1
                let date = timePickr.date
                 let strTime = date.dateStringWith(strFormat: "hh:mm a")
                startTimeTextField.text = strTime
                print(strTime)
             }
           self.view.endEditing(true)
             //self.myTextField.resignFirstResponder() // 2.5
         }
    @objc func tapDoneEndTime(sender: Any, timePicker: UIDatePicker) {
                print(timePicker)
                if let timePickr = self.startTimeTextField.inputView as? UIDatePicker { // 2.1
                   let date = timePickr.date
                    let strTime = date.dateStringWith(strFormat: "hh:mm a")
                   endTimeTextField.text = strTime
                   print(strTime)
                }
              self.view.endEditing(true)
                //self.myTextField.resignFirstResponder() // 2.5
            }

    
    func setupButtonUI(){
        if(isHistoryButtonSelected!){
            scrollBGView.isHidden = true
            bookingHistoryTableView.isHidden = false
            bookHallConfirmButton.isHidden = true
            bookHallHistoryButton.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
            bookHallHistoryButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
            bookHallButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                      bookHallButton.setTitleColor(UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), for: .normal)
        }else{
            scrollBGView.isHidden = false
            bookingHistoryTableView.isHidden = true
            bookHallConfirmButton.isHidden = false
            bookHallButton.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
                       bookHallButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
                       bookHallHistoryButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                                 bookHallHistoryButton.setTitleColor(UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), for: .normal)
            
        }
    }
    @IBAction func bookHallAction(_ sender: Any) {
       // logoutAction()
        if(isHistoryButtonSelected!){
           // bookingHistoryTableView.isHidden = true
           isHistoryButtonSelected = false
            setupButtonUI()
        } else {
            
        }
    }
    
    func logoutAction() {
        let alertMessage = "Are you sure you want to cancel the booking?"
           let alert = UIAlertController(title: "", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.setValue(NSAttributedString(string: alertMessage, attributes: [NSAttributedString.Key.font : UIFont(name: "WorkSans-Regular", size: CGFloat(19))
, NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedMessage")
           
           alert.addAction(UIAlertAction(title: "Yes, Cancel", style: .destructive, handler: { (action) in
           }))
           alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 69/255, blue: 86/255, alpha: 1)

           self.present(alert, animated: true, completion: nil)
        
       }
    
    
    
    @IBAction func bookHallHistoryAction(_ sender: Any) {
        if(isHistoryButtonSelected!){
            
        }
        else{
            // bookingHistoryTableView.isHidden = false
            isHistoryButtonSelected = true
            setupButtonUI()
        }
    }
    
    
    @IBAction func bookHallConfirmationAction(_ sender: UIButton) {
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
extension BookHallsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookHallTableViewCell.identifier(), for: indexPath) as! BookHallTableViewCell
        cell.setupUIData()
        return cell
        
    }
    
    
    
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // openViewController(controller: BookHallsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
            
        }
    }

extension Date {
        func dateStringWith(strFormat: String) -> String {
               let dateFormatter = DateFormatter()
               dateFormatter.timeZone = Calendar.current.timeZone
               dateFormatter.locale = Calendar.current.locale
               dateFormatter.dateFormat = strFormat
               return dateFormatter.string(from: self)
           }
       }
    

