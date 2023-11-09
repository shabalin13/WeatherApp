//
//  FeelsTemperatureDescription.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

enum FeelsTemperatureDescription: Hashable {
    
    case similar
    case warmer
    case colder
    
    init(temperature: Int, feelsTemperature: Int) {
        if feelsTemperature == temperature {
            self = .similar
        } else if feelsTemperature > temperature {
            self = .warmer
        } else {
            self = .colder
        }
    }
    
    var description: String {
        switch self {
        case .similar:
            return "Similar to the actual temperature."
        case .warmer:
            return "Humidity is making it feel warmer."
        case .colder:
            return "Wind is making it feel colder."
        }
    }
    
}
