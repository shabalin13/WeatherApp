//
//  HourlyForecastItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

import Foundation

typealias HourlyForecastItems = [HourlyForecastItem]

struct HourlyForecastItem: Hashable {
    
    private let date: Int
    private let timezone: Int
    private(set) var iconName: String
    private let temperature: Int
    private let probabilityOfPrecipitation: Int
    
    init(date: Int, timezone: Int, iconName: String, temperature: Int, probabilityOfPrecipitation: Int) {
        self.date = date
        self.timezone = timezone
        self.iconName = iconName
        self.temperature = temperature
        self.probabilityOfPrecipitation = probabilityOfPrecipitation
    }
    
    var dateString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: date)
    }
    
    var temperatureString: String {
        return "\(temperature)°"
    }
    
    var probabilityOfPrecipitationString: String {
        if probabilityOfPrecipitation == 0 {
            return " "
        } else {
            return "\(probabilityOfPrecipitation)%"
        }
    }
    
}
