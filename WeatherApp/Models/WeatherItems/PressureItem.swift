//
//  PressureItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

struct PressureItem: Hashable {
    
    let pressure: Int
    
    init(pressure: Int) {
        self.pressure = Int((Double(pressure) / 0.75006).rounded())
    }
    
}
