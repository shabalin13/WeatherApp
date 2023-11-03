//
//  HourlyForecastItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

typealias HourlyForecastItems = [HourlyForecastItem]

struct HourlyForecastItem: Hashable {
    
    let date: Int
    let iconID: String
    let temperature: Int
    
}
