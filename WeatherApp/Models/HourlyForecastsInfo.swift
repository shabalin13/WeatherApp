//
//  HourlyForecastsInfo.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct HourlyForecastsInfo {
    
    enum RootKeys: String, CodingKey {
        case hourlyForecasts = "list"
        case cityInfo = "city"
    }
    
    enum CityInfoKeys: String, CodingKey {
        case cityID = "id"
        case cityName = "name"
        case timezone
        case sunrizeTime = "sunrise"
        case sunsetTime = "sunset"
    }
    
    let hourlyForecasts: [HourlyForecast]
    
    let cityID: Int
    let cityName: String
    
    let timezone: Int
    
    let sunriseTime: Int
    let sunsetTime: Int
    
}


extension HourlyForecastsInfo: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        hourlyForecasts = try container.decode([HourlyForecast].self, forKey: .hourlyForecasts)
        
        let cityInfoContainer = try container.nestedContainer(keyedBy: CityInfoKeys.self, forKey: .cityInfo)
        cityID = try cityInfoContainer.decode(Int.self, forKey: .cityID)
        cityName = try cityInfoContainer.decode(String.self, forKey: .cityName)
        
        timezone = try cityInfoContainer.decode(Int.self, forKey: .timezone)
        
        sunriseTime = try cityInfoContainer.decode(Int.self, forKey: .sunrizeTime)
        sunsetTime = try cityInfoContainer.decode(Int.self, forKey: .sunsetTime)
    }
    
}

