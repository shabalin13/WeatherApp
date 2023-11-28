//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import RxSwift
import Dispatch

protocol CitiesViewModelProtocol {
    
    var cityItems: PublishSubject<CityItems> { get }
    
    func getCitiesInfo(cityName: String)
//    func comeBackFromCities()
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private var coordinator: CitiesCoordinatorProtocol
    private(set) var cityItems = PublishSubject<CityItems>()
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getCitiesInfo(cityName: String) {
        NetworkService().getCitiesInfo(cityName: cityName, userLocation: (55.79, 49.10)) { result in
            switch result {
            case .success(let citiesInfo):
                let cityItems = self.createCityItems(citiesInfo: citiesInfo)
                DispatchQueue.main.async {
                    self.cityItems.onNext(cityItems)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createCityItems(citiesInfo: CitiesInfo) -> CityItems {
        let cityItems = citiesInfo.results.map { cityInfo in
            CityItem(cityName: cityInfo.displayLines.joined(separator: " "))
        }
        return cityItems
    }
    
//    func comeBackFromCities() {
//        coordinator.comeBackFromCities()
//    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
    
}

