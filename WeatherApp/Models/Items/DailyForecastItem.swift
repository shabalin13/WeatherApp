//
//  DailyForecastItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

typealias DailyForecastItems = [DailyForecastItem]

struct DailyForecastItem: Hashable {
    
    let date: Int
    let iconName: String
    let temperatureMin: Int
    let temperatureMax: Int
    
}
