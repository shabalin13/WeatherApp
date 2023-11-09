//
//  FeelsTemperatureItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 06.11.2023.
//

struct FeelsTemperatureItem: Hashable {
    
    let feelsTemperature: Int
    let temperature: Int
    var description: FeelsTemperatureDescription {
        return .init(temperature: temperature, feelsTemperature: feelsTemperature)
    }
    
}
