//
//  CitiesItemIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 20.11.2023.
//

enum CitiesItemIdentifier: Hashable {
    
    case cityWeather(CityWeatherItem)
    
    var cityWeather: CityWeatherItem? {
        if case .cityWeather(let cityWeatherItem) = self {
            return cityWeatherItem
        } else {
            return nil
        }
    }
    
}
