//
//  CityWeatherItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 20.11.2023.
//

struct CityWeatherItem: Hashable {
    
    private(set) var isCurrentCity: Bool
    private(set) var cityName: String
    private let temperature: Int
    private(set) var weatherName: String
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
    
    var temperatureMinMaxString: String {
        return "Max: \(temperatureMax)°, Min: \(temperatureMin)°"
    }
    
}
