//
//  HumidityItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

import Foundation

struct HumidityItem: Hashable {
    
    private let humidity: Int
    private var dewTemperature: Int?
    
    init(humidity: Int, temperature: Double) {
        self.humidity = humidity
        
        if humidity == 0 {
            self.dewTemperature = nil
        } else {
            let a = 17.27
            let b = 237.7
            let f = (a * temperature) / (b + temperature) + log(Double(humidity) / 100)
            let dewTemperature = (b * f) / (a - f)
            self.dewTemperature = Int(dewTemperature.rounded())
        }
    }
    
    var humidityString: String {
        return "\(humidity)%"
    }
    
    var dewTemperatureString: String? {
        if let dewTemperature = dewTemperature {
            return "The dew point is \(dewTemperature)° right now."
        } else {
            return nil
        }
    }
    
}
