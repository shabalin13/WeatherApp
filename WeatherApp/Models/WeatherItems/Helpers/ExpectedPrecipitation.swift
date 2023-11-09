//
//  ExpectedPrecipitation.swift
//  WeatherApp
//
//  Created by DIMbI4 on 09.11.2023.
//

import Foundation

enum ExpectedPrecipitation: Hashable {
    
    case none
    case next24hours(precipitation: Int)
    case next10days(precipitation: Int, datetime: Int, timezone: Int)
    
    init(rains24hours: [Double], snows24hours: [Double],
         rains10days: [(precipitation: Double, datetime: Int, timezone: Int)],
         snows10days: [(precipitation: Double, datetime: Int, timezone: Int)]) {
        var rain24hours: Double = 0
        var snow24hours: Double = 0
        for idx in 0..<24 {
            rain24hours += rains24hours[idx]
            snow24hours += snows24hours[idx]
        }
        if rain24hours != 0 || snow24hours != 0 {
            self = .next24hours(precipitation: Int((rain24hours + snow24hours).rounded()))
        } else {
            for idx in 0..<10 {
                if rains10days[idx].precipitation != 0 || snows10days[idx].precipitation != 0 {
                    self = .next10days(precipitation: Int((rains10days[idx].precipitation + snows10days[idx].precipitation).rounded()), datetime: rains10days[idx].datetime, timezone: rains10days[idx].timezone)
                    break
                }
            }
            self = .none
        }
    }
    
    var description: String {
        switch self {
        case .none:
            return "None expected in next 10 days."
        case .next24hours(precipitation: let precipitation):
            return "\(precipitation) mm expected in next 24 hours."
        case .next10days(precipitation: let precipitation, datetime: let datetime, timezone: let timezone):
            let date = Date(timeIntervalSince1970: TimeInterval(datetime))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
            
            return "Next expected is \(precipitation) mm on \(dateFormatter.string(from: date))"
        }
    }
    
}
