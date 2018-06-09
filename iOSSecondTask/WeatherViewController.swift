//
//  WeatherViewController.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/9/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {

    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var descrbLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
   
    @IBOutlet var minTemp: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    
    var weatherModel: WeatherModel?
    var weatherDescrb: Weather?
    var main: MainClass?
    var list: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName.text = weatherModel?.city.name
        weatherLabel.text = (weatherDescrb?.main).map { $0.rawValue }
        descrbLabel.text = (weatherDescrb?.description).map { $0.rawValue }
        tempLabel.text = "\((main?.temp)!)"
        maxTemp.text = "\((main?.tempMax)!)"
        minTemp.text = "\((main?.tempMin)!)"
        pressure.text = "\((main?.pressure)!)"
        humidity.text = "\((main?.humidity)!)"
        dateLabel.text = list?.dtTxt
    }

}
