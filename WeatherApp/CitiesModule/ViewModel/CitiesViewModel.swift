//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

protocol CitiesViewModelProtocol {
    
    func getCitiesInfo()
//    func comeBackFromCities()
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private var coordinator: CitiesCoordinatorProtocol
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getCitiesInfo() {
        NetworkService().getCitiesInfo(cityName: "Ka", userLocation: (55.79, 49.10)) { result in
            print(result)
        }
    }
    
//    func comeBackFromCities() {
//        coordinator.comeBackFromCities()
//    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
    
}

