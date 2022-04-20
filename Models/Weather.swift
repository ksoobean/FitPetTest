//
//  Weather.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import Foundation

struct WeatherResponse: Decodable {
    let weatherForecast: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case weatherForecast = "consolidated_weather"
    }
}

struct Weather: Decodable {
    let weatherState: String // "Heavy Cloud"
    let weatherAbbr: String // "hc"
    let date: String // "2022-04-21"
    let minTemp: Double // 7.3999999999999995
    let maxTemp: Double // 15.120000000000001
    
    enum CodingKeys : String, CodingKey {
        case weatherState = "weather_state_name"
        case weatherAbbr = "weather_state_abbr"
        case date = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
    }
}
