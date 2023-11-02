//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

protocol WeatherViewModelProtocol {
    
    func goToCities()
    func getTempRequest()
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private var coordinator: WeatherCoordinatorProtocol
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToCities() {
        coordinator.goToCities()
    }
    
    func getTempRequest() {
//        NetworkService().getCurrentWeather(cityName: "Kemerovo") { result in
//            print(result)
//        }
        
//        NetworkService().getHourlyForecastsInfo(cityName: "Kemerovo", hoursCount: 96) { result in
//            print(result)
//        }
        
        NetworkService().getDailyForecastsInfo(cityName: "Kemerovo", daysCount: 16) { result in
            print(result)
        }
    }
    
}
