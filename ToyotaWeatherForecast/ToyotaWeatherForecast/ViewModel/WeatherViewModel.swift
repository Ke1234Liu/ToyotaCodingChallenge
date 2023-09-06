//
//  WeatherViewModel.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherInfo: WeatherInfo?
    @Published var weatherForecast: WeatherForecast?
    @Published var errorMessage: String?
    
    private let networkService: NetworkRepresentable
    
    init(networkService: NetworkRepresentable = NetworkLayer()) {
        self.networkService = networkService
    }
    
    func fetchWeather(for city: String) {
        Task {
            do {
                let endpoint = APIEndpoints.currentWeather(city: city)
                let weather = try await networkService.fetchWeather(urlStr: endpoint.completeURL)
                self.weatherInfo = weather
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
                self.weatherInfo = nil
            }
        }
    }
    
    func fetchWeatherForecast(for city: String) {
        Task {
            do {
                let endpoint = APIEndpoints.fiveDayForecast(city: city)
                let weather = try await networkService.fetchWeatherForeCast(urlStr: endpoint.completeURL)
                self.weatherForecast = weather
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
                self.weatherForecast = nil
            }
        }
    }
}
