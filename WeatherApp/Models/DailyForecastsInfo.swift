//
//  DailyForecastsInfo.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct DailyForecastsInfo {
    
    enum RootKeys: String, CodingKey {
        case dailyForecasts = "list"
        case cityInfo = "city"
    }
    
    enum CityInfoKeys: String, CodingKey {
        case cityID = "id"
        case cityName = "name"
        case timezone
    }
    
    let dailyForecasts: [DailyForecast]
    
    let cityID: Int
    let cityName: String
    
    let timezone: Int
}

extension DailyForecastsInfo: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        dailyForecasts = try container.decode([DailyForecast].self, forKey: .dailyForecasts)
        
        let cityInfoContainer = try container.nestedContainer(keyedBy: CityInfoKeys.self, forKey: .cityInfo)
        cityID = try cityInfoContainer.decode(Int.self, forKey: .cityID)
        cityName = try cityInfoContainer.decode(String.self, forKey: .cityName)
        
        timezone = try cityInfoContainer.decode(Int.self, forKey: .timezone)
    }
}

