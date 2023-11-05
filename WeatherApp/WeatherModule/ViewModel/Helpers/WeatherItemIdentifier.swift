//
//  WeatherItemIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

enum WeatherItemIdentifier: Hashable {
    
//    case main
    case hourlyForecast(HourlyForecastItem)
//    case dailyForecasts
//    case wind
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
}
