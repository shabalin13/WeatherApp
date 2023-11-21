//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

protocol CitiesViewModelProtocol {
    
//    func comeBackFromCities()
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private var coordinator: CitiesCoordinatorProtocol
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
//    func comeBackFromCities() {
//        coordinator.comeBackFromCities()
//    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
    
}

