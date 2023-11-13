//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import Dispatch
import RxSwift

protocol WeatherViewModelProtocol {
    
    var weatherItem: PublishSubject<WeatherItem> { get }
    var sections: [WeatherSectionIdentifier] { get set }
    
    func goToCities()
    func getWeather()
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    var sections = [WeatherSectionIdentifier]()
    
    private var coordinator: WeatherCoordinatorProtocol
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    private let cityName = "Kazan"
    
    private var currentWeather: CurrentWeather?
    private var hourlyForecastsInfo: HourlyForecastsInfo?
    private var dailyForecastsInfo: DailyForecastsInfo?
    
    private(set) var weatherItem = PublishSubject<WeatherItem>()
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToCities() {
        coordinator.goToCities()
    }
    
    func getWeather() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            self.networkService.getCurrentWeather(cityName: self.cityName) { result in
                switch result {
                case .success(let currentWeather):
                    self.currentWeather = currentWeather
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            self.networkService.getHourlyForecastsInfo(cityName: self.cityName, hoursCount: 24) { result in
                switch result {
                case .success(let hourlyForecastsInfo):
                    self.hourlyForecastsInfo = hourlyForecastsInfo
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            self.networkService.getDailyForecastsInfo(cityName: self.cityName, daysCount: 10) { result in
                switch result {
                case .success(let dailyForecastsInfo):
                    self.dailyForecastsInfo = dailyForecastsInfo
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global()) {
            
            if let currentWeather = self.currentWeather,
               let hourlyForecastsInfo = self.hourlyForecastsInfo,
               let dailyForecastsInfo = self.dailyForecastsInfo {
                let weatherItem = self.createWeatherItem(currentWeather: currentWeather, hourlyForecastsInfo: hourlyForecastsInfo, dailyForecastsInfo: dailyForecastsInfo)
                DispatchQueue.main.async {
                    self.weatherItem.onNext(weatherItem)
                }
            } else {
//                self.weatherItem.onError()
            }
        }
        
    }
    
    private func createWeatherItem(currentWeather: CurrentWeather, hourlyForecastsInfo: HourlyForecastsInfo, dailyForecastsInfo: DailyForecastsInfo) -> WeatherItem {
        
        let hourlyForecastItems = hourlyForecastsInfo.hourlyForecasts.map { hourlyForecast in
            let iconName = WeatherIDtoIconNameMapping(rawValue: hourlyForecast.weatherID)!.iconName + hourlyForecast.partOfDay
            return HourlyForecastItem(date: hourlyForecast.datetime, timezone: hourlyForecastsInfo.timezone, iconName: iconName, temperature: Int(hourlyForecast.temperature.rounded()), probabilityOfPrecipitation: Int(hourlyForecast.probabilityOfPrecipitation * 100))
        }
        
        let temperatureTotalMin = Int(dailyForecastsInfo.dailyForecasts.min(by: { $0.temperatureMin < $1.temperatureMin })?.temperatureMin.rounded() ?? 0)
        let temperatureTotalMax = Int(dailyForecastsInfo.dailyForecasts.max(by: { $0.temperatureMax < $1.temperatureMax })?.temperatureMax.rounded() ?? 0)
        
        let dailyForecastItems = dailyForecastsInfo.dailyForecasts.enumerated().map { idx, dailyForecast in
            let iconName = WeatherIDtoIconNameMapping(rawValue: dailyForecast.weatherID)!.iconName + "d"
            return DailyForecastItem(isToday: idx == 0 ? true : false, date: dailyForecast.datetime, timezone: dailyForecastsInfo.timezone, iconName: iconName, temperatureMin: Int(dailyForecast.temperatureMin.rounded()), temperatureMax: Int(dailyForecast.temperatureMax.rounded()), probabilityOfPrecipitation: Int(dailyForecast.probabilityOfPrecipitation * 100), temperatureTotalMin: temperatureTotalMin, temperatureTotalMax: temperatureTotalMax)
        }
        
        let windItem = WindItem(speed: Int(currentWeather.windSpeed.rounded()), gust: Int(currentWeather.windGust.rounded()), deg: currentWeather.windDeg)
        
        let feelsTemperatureItem = FeelsTemperatureItem(feelsTemperature: Int(currentWeather.feelsTemperature.rounded()), temperature: Int(currentWeather.temperature.rounded()))
        
        let visibilityItem = VisibilityItem(visibility: currentWeather.visibility)
        
        let sunItem: SunItem = SunItem(sunriseTime: currentWeather.sunriseTime, sunsetTime: currentWeather.sunsetTime, timezone: currentWeather.timezone)
        
        let humidityItem = HumidityItem(humidity: currentWeather.humidity, temperature: currentWeather.temperature)
        
        let pressureItem = PressureItem(pressure: currentWeather.pressure)
        
        let precipitation = currentWeather.rain != 0 ? Int(currentWeather.rain.rounded()) : Int(currentWeather.snow.rounded())
        
        let rains24hours = hourlyForecastsInfo.hourlyForecasts.map { $0.rain }
        let snows24hours = hourlyForecastsInfo.hourlyForecasts.map { $0.snow }
        let rains10days = dailyForecastsInfo.dailyForecasts.map { ($0.rain, $0.datetime, dailyForecastsInfo.timezone) }
        let snows10days = dailyForecastsInfo.dailyForecasts.map { ($0.snow, $0.datetime, dailyForecastsInfo.timezone) }
        let expectedPrecipitation = ExpectedPrecipitation(rains24hours: rains24hours, snows24hours: snows24hours, rains10days: rains10days, snows10days: snows10days)
        
        let precipitationItem = PrecipitationItem(precipitation: precipitation, expectedPrecipitation: expectedPrecipitation)
        
        
        return WeatherItem(hourlyForecastItems: hourlyForecastItems, dailyForecastItems: dailyForecastItems, windItem: windItem, feelsTemperatureItem: feelsTemperatureItem, visibilityItem: visibilityItem, sunItem: sunItem, humidityItem: humidityItem, pressureItem: pressureItem, precipitationItem: precipitationItem)
        
    }
    
}
