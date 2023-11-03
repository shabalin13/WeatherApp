//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import Dispatch

protocol WeatherViewModelProtocol {
    
    var weatherItem: WeatherItem? { get }
    
    func goToCities()
    func getWeather()
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private var coordinator: WeatherCoordinatorProtocol
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    private let cityName = "Kazan"
    
    private var currentWeather: CurrentWeather?
    private var hourlyForecastsInfo: HourlyForecastsInfo?
    private var dailyForecastsInfo: DailyForecastsInfo?
    
    private(set) var weatherItem: WeatherItem?
    
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
        
        group.notify(queue: DispatchQueue.main) {
            
            if let currentWeather = self.currentWeather,
               let hourlyForecastsInfo = self.hourlyForecastsInfo,
               let dailyForecastsInfo = self.dailyForecastsInfo {
                self.weatherItem = WeatherItem(currentWeather: currentWeather, hourlyForecastsInfo: hourlyForecastsInfo, dailyForecastsInfo: dailyForecastsInfo)
            } else {
                self.weatherItem = nil
            }
            print(self.weatherItem)
        }
        
    }
    
}
