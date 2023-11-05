//
//  WeatherSectionIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

enum WeatherSectionIdentifier: Hashable {
    case main
    case hourlyForecasts(imageName: String, titleName: String)
    case dailyForecasts(imageName: String, titleName: String)
    case wind(imageName: String, titleName: String)
    case sun(imageName: String, titleName: String)
    case feelsTemperature(imageName: String, titleName: String)
    case precipitation(imageName: String, titleName: String)
    case visibility(imageName: String, titleName: String)
    case humidity(imageName: String, titleName: String)
    case pressure(imageName: String, titleName: String)
}
