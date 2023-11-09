//
//  SquareItemIdentifier.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

enum SquareItemIdentifier: Hashable {
    
    case feelsTemperature(FeelsTemperatureItem)
    case visibility(VisibilityItem)
    case precipitation(PrecipitationItem)
    case sun(SunItem)
    case humidity(HumidityItem)
    case pressure(PressureItem)
    
}
