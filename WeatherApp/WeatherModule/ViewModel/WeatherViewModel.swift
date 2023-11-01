//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

protocol WeatherViewModelProtocol {
    
    func goToCities()
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private var coordinator: WeatherCoordinatorProtocol
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToCities() {
        coordinator.goToCities()
    }
    
}
