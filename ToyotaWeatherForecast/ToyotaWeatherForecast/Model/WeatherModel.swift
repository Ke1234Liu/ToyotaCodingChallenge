//
//  WeatherM.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import Foundation

struct WeatherInfo: Decodable, Equatable {
    var name: String
    var coordinates: Coordinates?
    var mainInfo: MainInfo?
    var windInfo: WindInfo?
    var weatherConditions: [WeatherCondition]?
    var visibility: Double
    
    static func == (lhs: WeatherInfo, rhs: WeatherInfo) -> Bool {
        return lhs.name == rhs.name
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case coordinates = "coord"
        case mainInfo = "main"
        case windInfo = "wind"
        case weatherConditions = "weather"
        case visibility
    }
}

struct Coordinates: Decodable {
    var longitude: Double
    var latitude: Double

    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat" 
    }
}

struct MainInfo: Decodable {
    var temperature: Double
    var humidity: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WindInfo: Decodable {
    var speed: Double
}

struct WeatherCondition: Decodable {
    var main: String
    var description: String
    var icon: String
}


struct WeatherForecast: Decodable {
    var city: City
    var weatherList: [WeatherList]

    private enum CodingKeys: String, CodingKey {
        case city
        case weatherList = "list"
    }
}

struct City: Decodable {
    var name: String
}

struct WeatherList: Decodable {
    var mainWeather: MainWeather
    var weather: [Weather]

    private enum CodingKeys: String, CodingKey {
        case weather
        case mainWeather = "main"
    }
}

extension WeatherList: Identifiable, Hashable {
    
    var id: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: WeatherList, rhs: WeatherList) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MainWeather: Decodable {
    var tempMax: Double
    var tempMin: Double

    private enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct Weather: Decodable {
    var main: String
    var icon: String
}
