//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct WeatherItem: Hashable {
    
    let hourlyForecastItems: HourlyForecastItems
    let dailyForecastItems: DailyForecastItems
    let windItem: WindItem
    let feelsTemperatureItem: FeelsTemperatureItem
    let visibilityItem: VisibilityItem
    let sunItem: SunItem
    let humidityItem: HumidityItem
    let pressureItem: PressureItem
    let precipitationItem: PrecipitationItem
    
}
