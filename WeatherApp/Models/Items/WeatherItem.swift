//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 02.11.2023.
//

struct WeatherItem: Hashable {
    
    let currentWeatherItem: CurrentWeatherItem
    let hourlyForecastItems: HourlyForecastItems
    let dailyForecastItems: DailyForecastItems
    
}

extension WeatherItem {
    
    init(currentWeather: CurrentWeather, 
         hourlyForecastsInfo: HourlyForecastsInfo,
         dailyForecastsInfo: DailyForecastsInfo) {
        
        currentWeatherItem = CurrentWeatherItem(
            weatherID: currentWeather.weatherID, 
            weatherName: currentWeather.weatherName,
            weatherDescription: currentWeather.weatherDescription,
            iconName: WeatherIDtoIconNameMapping(rawValue: currentWeather.weatherID)!.iconName,
            temperature: Int(currentWeather.temperature.rounded()),
            feelsTemperature: Int(currentWeather.feelsTemperature.rounded()),
            temperatureMin: Int(currentWeather.temperatureMin.rounded()),
            temperatureMax: Int(currentWeather.temperatureMax.rounded()),
            pressure: currentWeather.pressure, 
            humidity: currentWeather.humidity,
            visibility: currentWeather.visibility,
            sunriseTime: currentWeather.sunriseTime, 
            sunsetTime: currentWeather.sunsetTime,
            windSpeed: currentWeather.windSpeed,
            windDeg: currentWeather.windDeg,
            windGust: currentWeather.windGust,
            rain: currentWeather.rain, 
            snow: currentWeather.snow,
            datetime: currentWeather.datetime,
            timezone: currentWeather.timezone,
            cityID: currentWeather.cityID,
            cityName: currentWeather.cityName)
        
        hourlyForecastItems = hourlyForecastsInfo.hourlyForecasts.map { hourlyForecast in
            let iconName = WeatherIDtoIconNameMapping(rawValue: hourlyForecast.weatherID)!.iconName + hourlyForecast.partOfDay
            return HourlyForecastItem(date: hourlyForecast.datetime, timezone: hourlyForecastsInfo.timezone, iconName: iconName, temperature: Int(hourlyForecast.temperature.rounded()))
        }
        
        dailyForecastItems = dailyForecastsInfo.dailyForecasts.map { dailyForecast in
            let iconName = WeatherIDtoIconNameMapping(rawValue: dailyForecast.weatherID)!.iconName + "d"
            return DailyForecastItem(date: dailyForecast.datetime, timezone: dailyForecastsInfo.timezone, iconName: iconName, temperatureMin: Int(dailyForecast.temperatureMin.rounded()), temperatureMax: Int(dailyForecast.temperatureMax.rounded()), probabilityOfPrecipitation: Int(dailyForecast.probabilityOfPrecipitation * 100))
        }
        
    }
    
}
