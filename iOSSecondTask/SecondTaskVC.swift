//
//  SecondTask.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/24/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation
import Alamofire
class SecondTaskVC: UIViewController {
    
    @IBOutlet var temp: UILabel!
    
    @IBOutlet var datenTime: UILabel!
    
    @IBOutlet var wind: UILabel!
    
    var weatherModel: WeatherModelDecodable?
    var listModel: ListDecodable?
    
    override func viewDidLoad() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3")
        
        Alamofire.request(url!).responseJSON { (response) in
            
            let result = response.data
            
            do{
                let decoder = JSONDecoder()
                self.weatherModel = try decoder.decode(WeatherModelDecodable.self, from: result!)
                print(self.weatherModel!.city.name)
                // I want to get the city name, just for test Alamofire and decoder
            }catch let error{
                print("error in decoding",error.localizedDescription)
                
            }
            
        }
        
        parseJSON()
    }
    
    func parseJSON(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3")
        
        Alamofire.request(url!).responseJSON { (response) in
            
            let result = response.data
            
            do{
                let decoder = JSONDecoder()
                self.listModel = try decoder.decode(ListDecodable.self, from: result!)
                print(String(describing: self.listModel?.clouds.all))
                // same thing here
            }catch let error{
                print("error1 in decoding",error.localizedDescription)
                
            }
        }
    }
}

