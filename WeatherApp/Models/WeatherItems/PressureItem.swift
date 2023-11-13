//
//  PressureItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

struct PressureItem: Hashable {
    
    private let pressure: Int
    
    init(pressure: Int) {
        self.pressure = pressure
    }
    
    var mmHgPressureString: String {
        let mmHgPressure = Int((Double(pressure) * 0.75006).rounded())
        return "\(mmHgPressure)"
    }
    
}
