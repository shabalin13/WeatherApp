//
//  FeelsTemperatureItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 06.11.2023.
//

struct FeelsTemperatureItem: Hashable {
    
    private let feelsTemperature: Int
    private let temperature: Int
    private var description: FeelsTemperatureDescription {
        return .init(temperature: temperature, feelsTemperature: feelsTemperature)
    }
    
    init(feelsTemperature: Int, temperature: Int) {
        self.feelsTemperature = feelsTemperature
        self.temperature = temperature
    }
    
    var feelsTemperatureString: String {
        return "\(feelsTemperature)°"
    }
    
    var descriptionString: String {
        return description.description
    }
    
}
