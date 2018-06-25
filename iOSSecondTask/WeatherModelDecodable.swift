//
//  WeatherModelDecodable.swift
//  
//
//  Created by MacBook Pro on 6/24/18.
//

import Foundation

struct WeatherModelDecodable: Decodable{
    let list: [List]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
        case city = "city"
    }
}

struct CityDecodable: Decodable {
    let id: Int
    let name: String
    let country: String
    let population: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case population = "population"
    }
}

struct ListDecodable: Decodable {
    let dt: Int
    let main: MainDecodable
    let weather: [WeatherDecodable]
    let clouds: CloudsDecodable
    let wind: WindDecodable
    let rain: RainDecodable
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case rain = "rain"
        case dtTxt = "dt_txt"
    }
}

struct CloudsDecodable: Decodable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct MainDecodable: Decodable {
    let temp: Double
    let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
    }
}

struct RainDecodable: Decodable {
    let the3H: Double
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct WeatherDecodable: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct WindDecodable: Decodable {
    let speed: Double
    let deg: Double
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}
