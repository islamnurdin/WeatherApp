//
//  ViewController.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/4/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    var weatherData = [WeatherModel]()
    var mainClass = [MainClass]()
    var cityClass = [City]()
    var weatherClass = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONData {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Converting JSON
    
    func parse(json: JSON) {
        for result in json["list"].arrayValue {
            let temp_min = result["main"]["temp_min"].doubleValue
            let temp_max = result["main"]["temp_max"].doubleValue
            let temp = result["main"]["temp"].doubleValue
            let pressure = result["main"]["pressure"].doubleValue
            let humidity = result["main"]["humidity"].intValue
            
            let weatherMain = MainClass(temp: temp, tempMin: temp_min, tempMax: temp_max, pressure: pressure, humidity: humidity)
            mainClass.append(weatherMain)
            print("success" + "\(mainClass)")
            
            for result1 in result["weather"].arrayValue{
                let main = result1["main"].stringValue
                let description = result1["description"].stringValue
                let weather = Weather(main: MainEnum(rawValue: main)!, description: Description(rawValue: description)!)
                weatherClass.append(weather)
                print("SUCCESS " + "\(weatherClass)")
            }
        }
        
            let cityName = json["city"]["name"].stringValue
            let city = City(name: cityName)
            cityClass.append(city)
            print("SUCCESS!!!: \(cityName)" + "\(cityClass)")
        
    }

    // Displaying on tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = weatherData[indexPath.row].list.first?.dtTxt
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
    
    // Parsing JSON
    func getJSONData(completed: @escaping () -> ()) {
        if let filepath = Bundle.main.path(forResource: "weather", ofType: "json") {
                do{
                    let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .alwaysMapped)
                    let json = try JSON(data: data)
                    parse(json: json)
                } catch let error{
                    print("error is " + error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completed()
                }
        } else {
            print("file not found")
        }
    }
    
}

