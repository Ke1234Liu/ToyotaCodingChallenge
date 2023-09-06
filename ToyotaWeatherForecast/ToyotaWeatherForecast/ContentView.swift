//
//  ContentView.swift
//  ToyotaWeatherForecast
//
//  Created by Ke Liu on 9/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CurrentWeather(viewModel: WeatherViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
