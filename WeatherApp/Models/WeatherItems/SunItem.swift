//
//  SunItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

import Foundation

struct SunItem: Hashable {
    
    private let sunriseTime: Int
    private let sunsetTime: Int
    private let timezone: Int
    
    init(sunriseTime: Int, sunsetTime: Int, timezone: Int) {
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.timezone = timezone
    }
    
    var sunriseTimeString: String {
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunriseTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return "\(dateFormatter.string(from: sunriseDate))"
    }
    
    var sunsetTimeString: String {
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunsetTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return "Sunset: \(dateFormatter.string(from: sunsetDate))"
    }
    
}
