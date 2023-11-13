//
//  DailyForecastItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

typealias DailyForecastItems = [DailyForecastItem]

struct DailyForecastItem: Hashable {
    
    let isToday: Bool
    let date: Int
    let timezone: Int
    let iconName: String
    let temperatureMin: Int
    let temperatureMax: Int
    let probabilityOfPrecipitation: Int
    let temperatureTotalMin: Int
    let temperatureTotalMax: Int
    
}
