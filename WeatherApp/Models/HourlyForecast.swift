//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct HourlyForecast {
    
    enum RootKeys: String, CodingKey {
        case datetime = "dt"
        case mainInfo = "main"
        case weatherInfo = "weather"
        case cloudsInfo = "clouds"
        case windInfo = "wind"
        case rainInfo = "rain"
        case snowInfo = "snow"
        case visibility
        case probabilityOfPrecipitation = "pop"
        case systemInfo = "sys"
    }
    
    enum MainInfoKeys: String, CodingKey {
        case temperature = "temp"
        case feelsTemperature = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure
        case humidity
    }
    
    enum WeatherInfoKeys: String, CodingKey {
        case weatherID = "id"
        case weatherName = "main"
        case weatherDescription = "description"
        case iconID = "icon"
    }
    
    enum CloudsInfoKeys: String, CodingKey {
        case clouds = "all"
    }
    
    enum WindInfoKeys: String, CodingKey {
        case windSpeed = "speed"
        case windDeg = "deg"
        case windGust = "gust"
    }
    
    enum RainInfoKeys: String, CodingKey {
        case rain = "1h"
    }
    
    enum SnowInfoKeys: String, CodingKey {
        case snow = "1h"
    }
    enum SystemInfoKeys: String, CodingKey {
        case partOfDay = "pod"
    }
    
    let datetime: Int
    
    let temperature: Double
    let feelsTemperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Int
    let humidity: Int
    
    let weatherID: Int
    let weatherName: String
    let weatherDescription: String
    let iconID: String
    
    let clouds: Int
    
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    
    let rain: Double
    let snow: Double
    
    let visibility: Int
    
    let probabilityOfPrecipitation: Double
    
    let partOfDay: String
    
}

extension HourlyForecast: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        datetime = try container.decode(Int.self, forKey: .datetime)
        
        let mainInfoContainer = try container.nestedContainer(keyedBy: MainInfoKeys.self, forKey: .mainInfo)
        temperature = try mainInfoContainer.decode(Double.self, forKey: .temperature)
        feelsTemperature = try mainInfoContainer.decode(Double.self, forKey: .feelsTemperature)
        temperatureMin = try mainInfoContainer.decode(Double.self, forKey: .temperatureMin)
        temperatureMax = try mainInfoContainer.decode(Double.self, forKey: .temperatureMax)
        pressure = try mainInfoContainer.decode(Int.self, forKey: .pressure)
        humidity = try mainInfoContainer.decode(Int.self, forKey: .humidity)
        
        var weatherInfoUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .weatherInfo)
        var weatherID: Int?
        var weatherName: String?
        var weatherDescription: String?
        var iconID: String?
        
        while !weatherInfoUnkeyedContainer.isAtEnd {
            let weatherInfoContainer = try weatherInfoUnkeyedContainer.nestedContainer(keyedBy: WeatherInfoKeys.self)
            weatherID = try weatherInfoContainer.decode(Int.self, forKey: .weatherID)
            weatherName = try weatherInfoContainer.decode(String.self, forKey: .weatherName)
            weatherDescription = try weatherInfoContainer.decode(String.self, forKey: .weatherDescription)
            iconID = try weatherInfoContainer.decode(String.self, forKey: .iconID)
            break
        }
        
        guard let weatherID = weatherID,
                let weatherName = weatherName,
                let weatherDescription = weatherDescription,
                let iconID = iconID else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [RootKeys.weatherInfo], debugDescription: "weatherInfo cannot be empty"))
        }
        
        self.weatherID = weatherID
        self.weatherName = weatherName
        self.weatherDescription = weatherDescription
        self.iconID = iconID
        
        let cloudsInfoContainer = try container.nestedContainer(keyedBy: CloudsInfoKeys.self, forKey: .cloudsInfo)
        clouds = try cloudsInfoContainer.decode(Int.self, forKey: .clouds)
        
        let windInfoContainer = try container.nestedContainer(keyedBy: WindInfoKeys.self, forKey: .windInfo)
        windSpeed = try windInfoContainer.decode(Double.self, forKey: .windSpeed)
        windDeg = try windInfoContainer.decode(Int.self, forKey: .windDeg)
        windGust = try windInfoContainer.decode(Double.self, forKey: .windGust)
        
        let rainInfoContainer = try? container.nestedContainer(keyedBy: RainInfoKeys.self, forKey: .rainInfo)
        rain = try rainInfoContainer?.decodeIfPresent(Double.self, forKey: .rain) ?? 0
        
        let snowInfoContainer = try? container.nestedContainer(keyedBy: SnowInfoKeys.self, forKey: .snowInfo)
        snow = try snowInfoContainer?.decodeIfPresent(Double.self, forKey: .snow) ?? 0
        
        visibility = try container.decode(Int.self, forKey: .visibility)
        
        probabilityOfPrecipitation = try container.decode(Double.self, forKey: .probabilityOfPrecipitation)
        
        let systemInfoContainer = try container.nestedContainer(keyedBy: SystemInfoKeys.self, forKey: .systemInfo)
        partOfDay = try systemInfoContainer.decode(String.self, forKey: .partOfDay)
    }
}

