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
        
        // fix iconID to be converted for API id to my iconID
        currentWeatherItem = CurrentWeatherItem(
            weatherID: currentWeather.weatherID, 
            weatherName: currentWeather.weatherName,
            weatherDescription: currentWeather.weatherDescription,
            // fix here
            iconID: currentWeather.iconID,
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
            HourlyForecastItem(date: hourlyForecast.datetime, iconID: hourlyForecast.iconID, temperature: Int(hourlyForecast.temperature.rounded()))
        }
        
        dailyForecastItems = dailyForecastsInfo.dailyForecasts.map { dailyForecast in
            DailyForecastItem(date: dailyForecast.datetime, iconID: dailyForecast.iconID, temperatureMin: Int(dailyForecast.temperatureMin.rounded()), temperatureMax: Int(dailyForecast.temperatureMax.rounded()))
        }
        
    }
    
}
