//
//  HumidityItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

import Foundation

struct HumidityItem: Hashable {
    
    let humidity: Int
    var dew_temperature: Int?
    
    init(humidity: Int, temperature: Double) {
        self.humidity = humidity
        
        if humidity == 0 {
            self.dew_temperature = nil
        } else {
            let a = 17.27
            let b = 237.7
            let f = (a * temperature) / (b + temperature) + log(Double(humidity) / 100)
            let dew_temperature = (b * f) / (a - f)
            self.dew_temperature = Int(dew_temperature.rounded())
        }
    }
}
