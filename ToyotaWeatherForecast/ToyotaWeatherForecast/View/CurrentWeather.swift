//
//  CurrentWeather.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import SwiftUI

struct CurrentWeather: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var city = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city", text: $city)
                        .padding()
                        
                    Button("Search") {
                        viewModel.fetchWeather(for: city)
                        viewModel.fetchWeatherForecast(for: city)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
                .background(Color.white)
                
                if let weatherInfo = viewModel.weatherInfo {
                    WeatherView(weatherInfo: weatherInfo)
                    Rectangle()
                        .foregroundColor(.orange)
                        .frame(height: 2)
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                if let weatherForecastInfo = viewModel.weatherForecast {
                    FiveDaysWeather(weatherList: weatherForecastInfo)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "sun.max")
                            .foregroundColor(.orange)
                        Text("Weather Forecast App")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                }
            }
            .background(Color(hue: 0.65, saturation: 0.80, brightness: 0.35))
        }
    }
}

struct WeatherView: View {
    let weatherInfo: WeatherInfo
    
    var body: some View {
        VStack {
            let name = weatherInfo.name
            Text(name)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .foregroundColor(.white)
            
            HStack {
                AsyncImage(url:URL(string: "https://openweathermap.org/img/wn/\(weatherInfo.weatherConditions?.first?.icon ?? "01d").png"))
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Text(weatherInfo.weatherConditions?.first?.main ?? "")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }

            if let temp = weatherInfo.mainInfo?.temperature {
                Text(showTemperature(Int(temp)))
                    .font(.system(size: 100))
                    .foregroundColor(.white)
            }
            if let windSpeed = weatherInfo.windInfo?.speed {
                infoView(param: "Wind Speed:", value: showWindSpeed(windSpeed))
            }
            if let humidity = weatherInfo.mainInfo?.humidity {
                infoView(param: "Humidity:", value: showHumidity(humidity))
            }
            if let maxTemp = weatherInfo.mainInfo?.tempMax {
                infoView(param: "High: ", value: showTemperature(Int(maxTemp)))
            }
            if let minTemp = weatherInfo.mainInfo?.tempMin {
                infoView(param: "Low: ", value: showTemperature(Int(minTemp)))
            }
        }
        .animation(.easeInOut)
    }
    
    func infoView(param: String, value: String) -> some View {
        HStack {
            Text(param)
                .font(.system(size: 25))
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.system(size: 25))
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 30)
    }
}

struct FiveDaysWeather: View {
    let weatherList: WeatherForecast

    var body: some View {
        HStack {
            ForEach(weatherList.weatherList, id: \.self) { weatherInfo in
                VStack {
                    AsyncImage(url:URL(string: "https://openweathermap.org/img/wn/\(weatherInfo.weather.first?.icon ?? "01d").png"))
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text(weatherInfo.weather.first?.main ?? "")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text("\(Int(weatherInfo.mainWeather.tempMax))")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text("\(Int(weatherInfo.mainWeather.tempMin))")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
            }
            
        }
        .animation(.easeInOut)
    }
    
    func infoView(param: String, value: String, size: Int = 15) -> some View {
        HStack {
            Text(param)
                .font(.system(size: CGFloat(size)))
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.system(size: CGFloat(size)))
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 25)
    }
}

struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherViewModel()
        CurrentWeather(viewModel: viewModel)
    }
}

func showTemperature(_ value: Int) -> String {
    return "\(value) \u{00B0}F"
}

func showWindSpeed(_ value: Double) -> String {
    return "\(String(Int(value))) mph"
}

func showHumidity(_ value: Double) -> String {
    return "\(String(Int(value))) \u{0025}"
}
