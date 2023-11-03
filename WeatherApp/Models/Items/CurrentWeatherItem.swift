//
//  CurrentWeatherItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct CurrentWeatherItem: Hashable {
    
    let weatherID: Int
    let weatherName: String
    let weatherDescription: String
    let iconID: String
    
    let temperature: Int
    let feelsTemperature: Int
    let temperatureMin: Int
    let temperatureMax: Int
    
    let pressure: Int
    let humidity: Int
    let visibility: Int
    
    let sunriseTime: Int
    let sunsetTime: Int
    
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    
    let rain: Double
    let snow: Double
    
    let datetime: Int
    let timezone: Int
    
    let cityID: Int
    let cityName: String
    
}
