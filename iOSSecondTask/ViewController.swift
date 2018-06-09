//
//  ViewController.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/4/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    var weatherData = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONData {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        for data in weatherData[indexPath.row].list{
//            cell.textLabel?.text = "Bishkek " + data.dtTxt
//        }
        cell.textLabel?.text = weatherData[indexPath.row].city.name + " " + (weatherData[indexPath.row].list.first?.dtTxt)!
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "displayDetails", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayDetails" {
            let destination = segue.destination as? WeatherViewController
            destination?.weatherModel = weatherData[(tableView.indexPathForSelectedRow?.row)!]
        } else{
            print("you can't do anything mfker")
        }
    }

    func getJSONData(completed: @escaping () -> ()) {
        if let filepath = Bundle.main.path(forResource: "weather", ofType: "json") {
                do{
                    let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .alwaysMapped)
                    self.weatherData = try [JSONDecoder().decode(WeatherModel.self, from: data)]
                    
                } catch let error{
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completed()
                }
        } else {
            print("file not found")
        }
    }
}

