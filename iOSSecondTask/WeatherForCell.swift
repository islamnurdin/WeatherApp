//
//  WeatherForCell.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 7/10/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation

class WeatherForCell {
    
    var weekDay: String?
    var tempDay: String?
    var tempNight: String?
    var dt: Date?
    var weatherDescrp: String?
    
    init (weekDay: String, tempNight: String, tempDay: String, dt: Date, weatherDescrp: String) {
        self.weekDay = weekDay
        self.tempDay = tempDay
        self.tempNight = tempNight
        self.dt = dt
        self.weatherDescrp = weatherDescrp
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.weekDay = aDecoder.decodeObject() as? String
        self.weekDay = aDecoder.decodeObject() as? String
        self.weekDay = aDecoder.decodeObject() as? String
        self.dt = aDecoder.decodeObject() as? Date
        self.weatherDescrp = aDecoder.decodeObject() as? String
    }
}
