//
//  CurrentWeatherItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 16.11.2023.
//

import Foundation

struct CurrentWeatherItem: Hashable {
    
    private(set) var isCurrentCity: Bool
    private(set) var cityName: String
    private let temperature: Int
    private var weatherName: String
    private let temperatureMin: Int
    private let temperatureMax: Int
    
    init(isCurrentCity: Bool, cityName: String, temperature: Int, weatherName: String, temperatureMin: Int, temperatureMax: Int) {
        self.isCurrentCity = isCurrentCity
        self.cityName = cityName
        self.temperature = temperature
        self.weatherName = weatherName
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
    }
    
    var temperatureString: String {
        return "\(temperature)°"
    }
    
    var weatherDescription: String {
        return weatherName + "\n" + "Max: \(temperatureMax)°, Min: \(temperatureMin)°"
    }
    
}
