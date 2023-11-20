//
//  WeatherSectionIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

enum WeatherSectionIdentifier: Hashable {
    
    case currentWeather
    case hourlyForecasts(imageName: String, titleName: String)
    case dailyForecasts(imageName: String, titleName: String)
    case wind(imageName: String, titleName: String)
    case squares
    
}
