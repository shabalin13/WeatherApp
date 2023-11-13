//
//  DailyForecastItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

import Foundation

typealias DailyForecastItems = [DailyForecastItem]

struct DailyForecastItem: Hashable {
    
    private var isToday: Bool
    private let date: Int
    private let timezone: Int
    private(set) var iconName: String
    private(set) var temperatureMin: Int
    private(set) var temperatureMax: Int
    private let probabilityOfPrecipitation: Int
    private(set) var temperatureTotalMin: Int
    private(set) var temperatureTotalMax: Int
    
    init(isToday: Bool, date: Int, timezone: Int, iconName: String, temperatureMin: Int, temperatureMax: Int, probabilityOfPrecipitation: Int, temperatureTotalMin: Int, temperatureTotalMax: Int) {
        self.isToday = isToday
        self.date = date
        self.timezone = timezone
        self.iconName = iconName
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.probabilityOfPrecipitation = probabilityOfPrecipitation
        self.temperatureTotalMin = temperatureTotalMin
        self.temperatureTotalMax = temperatureTotalMax
    }
    
    var dateString: String {
        if isToday {
            return "Today"
        } else {
            let date = Date(timeIntervalSince1970: TimeInterval(date))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
            return dateFormatter.string(from: date)
        }
    }
    
    var temperatureMinString: String {
        return "\(temperatureMin)°"
    }
    
    var temperatureMaxString: String {
        return "\(temperatureMax)°"
    }
    
    var probabilityOfPrecipitationString: String {
        if probabilityOfPrecipitation == 0 {
            return " "
        } else {
            return "\(probabilityOfPrecipitation)%"
        }
    }
    
}
