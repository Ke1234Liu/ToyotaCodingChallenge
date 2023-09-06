//
//  Endpoints.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import Foundation

enum APIKeys {
    static let openWeather = "1cb085c0e566c3080f5f99c9fc33c85c"
}

enum APIEndpoints {
    case currentWeather(city: String)
    case weatherByLocation(lat: Double, lon: Double)
    case fiveDayForecast(city: String)
    
    var completeURL: String {
        let apiKey = APIKeys.openWeather
        
        switch self {
        case .currentWeather(let city):
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial"
        case .weatherByLocation(let lat, let lon):
            return "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial"
            
        case .fiveDayForecast(let city):
            return "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&cnt=5&units=imperial"
        }
    }
}
