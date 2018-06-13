//
//  WeatherModel.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/9/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherModel {
    let list: [List]
    let city: City
}

struct City {
    let name: String
}

struct Coord {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct List {
    let main: MainClass
    let weather: [Weather]
    let dtTxt: String
}

struct Clouds {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct MainClass {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct Rain {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Weather {
    let main: MainEnum
    let description: Description
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
}

enum Description: String, Codable {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

struct Wind {
    let speed: Double
    let deg: Double
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

