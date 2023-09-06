//
//  NetworkLayer.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import Foundation

protocol NetworkRepresentable {
    func fetchWeather(urlStr: String) async throws -> WeatherInfo
    func fetchWeatherForeCast(urlStr: String) async throws -> WeatherForecast
}

final class NetworkLayer: NetworkRepresentable {
    
    private lazy var decoder = JSONDecoder()
    
    func fetchWeather(urlStr: String) async throws -> WeatherInfo {
        guard let url = URL(string: urlStr) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(WeatherInfo.self, from: data)
    }
    
    func fetchWeatherForeCast(urlStr: String) async throws -> WeatherForecast {
        guard let url = URL(string: urlStr) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(WeatherForecast.self, from: data)
    }
}





