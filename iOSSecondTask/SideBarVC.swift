//
//  SideBarVC.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/22/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation

class SideBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableArray = [String]()
    override func viewDidLoad() {
        tableArray = ["First", "Second"]
        print("this is sidebar")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
}
