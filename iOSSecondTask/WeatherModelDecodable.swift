//
//  WeatherModelDecodable.swift
//  
//
//  Created by MacBook Pro on 6/24/18.
//

import Foundation
import Alamofire

struct WeatherModelDecodable: Codable {
    let list: [ListDecodable]
    let city: CityDecodable
    enum CodinKeys: String, CodingKey{
        case list = "list"
        case city = "city"
    }
}

struct CityDecodable: Codable {
    let name: String
}
struct ListDecodable: Codable {
    let dt: Date
    let main: MainClassDecodable
    let weather: [WeatherDecodable]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey{
        case dt  = "dt"
        case main = "main"
        case weather = "weather"
        case dtTxt = "dt_txt"
    }
    
}
struct MainClassDecodable: Codable {
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
struct WeatherDecodable: Codable {
    let main: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
}
