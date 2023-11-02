//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct DailyForecast {
    
    enum RootKeys: String, CodingKey {
        case datetime = "dt"
        case sunrise
        case sunset
        case temperatureInfo = "temp"
        case feelsTemperatureInfo = "feels_like"
        case pressure
        case humidity
        case weatherInfo = "weather"
        case windSpeed = "speed"
        case windDeg = "deg"
        case windGust = "gust"
        case clouds
        case rain
        case snow
        case probabilityOfPrecipitation = "pop"
    }
    
    enum TemperatureInfoKeys: String, CodingKey {
        case temperatureMin = "min"
        case temperatureMax = "max"
        case temperatureNight = "night"
        case temperatureMorning = "morn"
        case temperatureDay = "day"
        case temperatureEvening = "eve"
    }
    
    enum FeelsTemperatureInfoKeys: String, CodingKey {
        case feelsTemperatureNight = "night"
        case feelsTemperatureMorning = "morn"
        case feelsTemperatureDay = "day"
        case feelsTemperatureEvening = "eve"
    }
    
    enum WeatherInfoKeys: String, CodingKey {
        case weatherID = "id"
        case weatherName = "main"
        case weatherDescription = "description"
        case iconID = "icon"
    }
    
    let datetime: Int
    let sunrise: Int
    let sunset: Int
    
    let temperatureMin: Double
    let temperatureMax: Double
    let temperatureNight: Double
    let temperatureMorning: Double
    let temperatureDay: Double
    let temperatureEvening: Double
    
    let feelsTemperatureNight: Double
    let feelsTemperatureMorning: Double
    let feelsTemperatureDay: Double
    let feelsTemperatureEvening: Double
    
    let pressure: Int
    let humidity: Int
    
    let weatherID: Int
    let weatherName: String
    let weatherDescription: String
    let iconID: String
    
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    
    let clouds: Int
    
    let rain: Double
    let snow: Double
    
    let probabilityOfPrecipitation: Double
}

extension DailyForecast: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        datetime = try container.decode(Int.self, forKey: .datetime)
        sunrise = try container.decode(Int.self, forKey: .sunrise)
        sunset = try container.decode(Int.self, forKey: .sunset)
        
        let temperatureInfoContainer = try container.nestedContainer(keyedBy: TemperatureInfoKeys.self, forKey: .temperatureInfo)
        temperatureMin = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureMin)
        temperatureMax = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureMax)
        temperatureNight = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureNight)
        temperatureMorning = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureMorning)
        temperatureDay = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureDay)
        temperatureEvening = try temperatureInfoContainer.decode(Double.self, forKey: .temperatureEvening)
        
        let feelsTemperatureInfoContainer = try container.nestedContainer(keyedBy: FeelsTemperatureInfoKeys.self, forKey: .feelsTemperatureInfo)
        feelsTemperatureNight = try feelsTemperatureInfoContainer.decode(Double.self, forKey: .feelsTemperatureNight)
        feelsTemperatureMorning = try feelsTemperatureInfoContainer.decode(Double.self, forKey: .feelsTemperatureMorning)
        feelsTemperatureDay = try feelsTemperatureInfoContainer.decode(Double.self, forKey: .feelsTemperatureDay)
        feelsTemperatureEvening = try feelsTemperatureInfoContainer.decode(Double.self, forKey: .feelsTemperatureEvening)
        
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
        
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
        
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        windDeg = try container.decode(Int.self, forKey: .windDeg)
        windGust = try container.decode(Double.self, forKey: .windGust)
        
        clouds = try container.decode(Int.self, forKey: .clouds)
        
        rain = try container.decodeIfPresent(Double.self, forKey: .rain) ?? 0
        snow = try container.decodeIfPresent(Double.self, forKey: .snow) ?? 0
        
        probabilityOfPrecipitation = try container.decode(Double.self, forKey: .probabilityOfPrecipitation)
    }
}

