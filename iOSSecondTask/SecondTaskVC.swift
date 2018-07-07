//
//  SecondTask.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/24/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation
import Alamofire

class SecondTaskVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var weatherModel: WeatherModelDecodable?
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descrpLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weekLabel: UILabel!
    
    var textArray = [ListDecodable]()
    var day: [Int] = []
    
    @IBOutlet weak var main: UIBarButtonItem!
    
    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        
        main.target = self.revealViewController()
        main.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.getData()
        
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3"
        let url = URL(string: urlString)
        Alamofire.request(url!).validate().responseJSON { (response) in
            let result = response.data
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                self.weatherModel = try decoder.decode(WeatherModelDecodable.self, from: result!)
                self.cityLabel.text = NSLocalizedString("city", comment: "city name")
                self.weatherIcon.image = UIImage(named: "Clear")

                if let data = self.weatherModel?.list {
                    self.textArray = data
                    
                    let threePMForecast = self.textArray.filter({
                        let utcDifference = TimeZone.current.secondsFromGMT() / 3600
                        let hour = Calendar.current.component(.hour, from: $0.dt)
                        return hour == (15 + utcDifference)
                    })
                    
                    for itemm in threePMForecast {
                        let days = Calendar.current.component(.day, from: itemm.dt)
                        self.day.append(days)
                    }
                }
                if self.textArray.count > 0 {
                    self.collView.reloadData()
                }
                
                
            } catch {
                print(error)
            }
        }
    }
    
    // UICollectionView // 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        if day.count > 5 {
            return day.count + 1
        } else {
            return day.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        cell.dayCollection.addBottomBorderWithColor(color: UIColor(red: 0, green: 0.7294, blue: 0.2275, alpha: 1.0), width: 1.6, height: 2.2)
        cell.dayLabel.addBottomBorderWithColor(color: UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0), width: 2.0, height: 2.0)
        
        let threePMForecast = textArray.filter({
            let utcDifference = TimeZone.current.secondsFromGMT() / 3600
            let hour = Calendar.current.component(.hour, from: $0.dt)
            return hour == (15 + utcDifference)
        })
        
        let tempToConvert = threePMForecast[indexPath.row].main.temp
        cell.dayTemp.text = String(format: "%.0f", tempToConvert - 273.15) + "°C"
        tempLabel.text = String(format: "%.0f", tempToConvert - 273.15) + "°C"
        
        let threeAMForecast = textArray.filter({
            let utcDifference = TimeZone.current.secondsFromGMT() / 3600
            let hour = Calendar.current.component(.hour, from: $0.dt)
            return hour == (3 + utcDifference)
        })
        
        let tempToConvertAM = threeAMForecast[indexPath.row].main.temp
        cell.nightTemp.text = String(format: "%.0f", tempToConvertAM - 273.15) + "°C"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        let date = threePMForecast[indexPath.row].dt
        var actualDate = dateFormatter.string(from: date)
        if date.isSame(Date()) {
            actualDate = "Today"
        }
        let day = NSLocalizedString(actualDate, comment: "week days")
        cell.dayCollection.text = day
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let threePMForecast = textArray.filter({
            let utcDifference = TimeZone.current.secondsFromGMT() / 3600
            let hour = Calendar.current.component(.hour, from: $0.dt)
            return hour == (15 + utcDifference)
        })
        
        self.tempLabel.text = String(format: "%.0f", threePMForecast[indexPath.row].main.temp - 273.15) + "°C"
        
        let dateFormatter = DateFormatter()
        let date = threePMForecast[indexPath.row].dt
        
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        let actualMonthDate = dateFormatter.string(from: date)
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        let dayInt = dateFormatter.string(from: date)
        self.dateLabel.text = ", " + dayInt + " " + NSLocalizedString(actualMonthDate, comment: "")
        
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        let actualWeekDate = dateFormatter.string(from: date)
        self.weekLabel.text = NSLocalizedString(actualWeekDate, comment: "")
        
        let getDecription = threePMForecast[indexPath.row].weather
        for description in getDecription {
            let descrp = description.main
            self.descrpLabel.text = NSLocalizedString(descrp, comment: "")
            descrpLabel.text = NSLocalizedString(descrp, comment: "")
            
            let statusCheck = self.descrpLabel.text
            
            if statusCheck == "Пасмурно" {
                self.weatherIcon.image = UIImage(named: "Cloud")
            }
            else if statusCheck == "Ясное небо" {
                self.weatherIcon.image = UIImage(named: "Clear")
            }
            else if statusCheck == "Дожди" {
                self.weatherIcon.image = UIImage(named: "Rain")
            }
            else {
                self.weatherIcon.image = UIImage(named: "warning")
            }
        }
        
        print(indexPath.section, indexPath.item)
    }
}
