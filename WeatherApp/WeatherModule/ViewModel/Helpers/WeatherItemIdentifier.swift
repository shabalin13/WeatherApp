//
//  WeatherItemIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

enum WeatherItemIdentifier: Hashable {
        
    case currentWeather(CurrentWeatherItem)
    case hourlyForecast(HourlyForecastItem)
    case dailyForecast(DailyForecastItem)
    case wind(WindItem)
    case squares(SquareItemIdentifier)
    
    var currentWeather: CurrentWeatherItem? {
        if case .currentWeather(let currentWeatherItem) = self {
            return currentWeatherItem
        } else {
            return nil
        }
    }
    
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
    
    var wind: WindItem? {
        if case .wind(let windItem) = self {
            return windItem
        } else {
            return nil
        }
    }
    
    var squares: SquareItemIdentifier? {
        if case .squares(let squareItemIdentifier) = self {
            return squareItemIdentifier
        } else {
            return nil
        }
    }
    
}
