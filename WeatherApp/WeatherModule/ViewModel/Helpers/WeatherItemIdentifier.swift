//
//  WeatherItemIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

enum WeatherItemIdentifier: Hashable {
    
//    case main
    case hourlyForecast(HourlyForecastItem)
    case dailyForecast(DailyForecastItem)
    case wind(CurrentWeatherItem)
//    case sun
//    case feelsTemperature
//    case precipitation
//    case visibility
//    case humidity
//    case pressure
    
    var hourlyForecast: HourlyForecastItem? {
        if case .hourlyForecast(let hourlyForecastItem) = self {
            return hourlyForecastItem
        } else {
            return nil
        }
    }
    
    var dailyForecast: DailyForecastItem? {
        if case .dailyForecast(let dailyForecastItem) = self {
            return dailyForecastItem
        } else {
            return nil
        }
    }
    
    var wind: CurrentWeatherItem? {
        if case .wind(let currentWeatherItem) = self {
            return currentWeatherItem
        } else {
            return nil
        }
    }
}
