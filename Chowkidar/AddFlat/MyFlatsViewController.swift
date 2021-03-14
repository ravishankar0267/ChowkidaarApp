//
//  MyFlatsViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 29/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class MyFlatsViewController: UIViewController {

    @IBOutlet weak var myFlatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFlatTableView.register(UINib(nibName: MyFlatsTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyFlatsTableViewCell.identifier())
             myFlatTableView.delegate = self
             myFlatTableView.dataSource = self
                    myFlatTableView.rowHeight = UITableView.automaticDimension
                   myFlatTableView.estimatedRowHeight = 300

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

extension MyFlatsViewController:UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyFlatsTableViewCell.identifier(), for: indexPath) as! MyFlatsTableViewCell
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
