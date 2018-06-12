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
    var listClass = [List]()
    var tableOpened = true
    
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
        
        if tableOpened == true{
            return 1
        } else{
            return weatherClass.count + 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
            cell.textLabel?.text = cityClass[indexPath.section].name
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
            if let filepath = Bundle.main.path(forResource: "weather", ofType: "json") {
                do{
                    let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                    let json = try JSON(data: data)
                    let main = self.weatherClass[dataIndex].main.rawValue
                    let descrp = self.weatherClass[dataIndex].description.rawValue
                    let temp = self.mainClass[dataIndex].temp
                    
                    // index out of range. Bad instruction shows here.
                    //let date = self.listClass[dataIndex].dtTxt
                    
                    for item in json["list"].arrayValue{
                        for _ in item["weather"].arrayValue{
                            cell.textLabel?.text = "date" + " - " + main + ": " + descrp + " Temp: " + "\(temp)"
                        }
                    }
                } catch{
                    print("error in displaying on sections")
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableOpened == true{
            tableOpened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableOpened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
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

