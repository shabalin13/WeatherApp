//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit

protocol WeatherCoordinatorProtocol: Coordinator {
    
    var parentCoordinator: AppCoordinatorProtocol { get }
    
    func goToCities()
    func childDidFinish(childCoordinator: Coordinator)
    
}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var parentCoordinator: AppCoordinatorProtocol
    private let navigationController: UINavigationController
    
    init(parentCoordinator: AppCoordinatorProtocol, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        print("WeatherCoordinator Start")
        let weatherViewModel = WeatherViewModel(coordinator: self)
        let weatherViewController = WeatherViewController(viewModel: weatherViewModel)
        navigationController.setViewControllers([weatherViewController], animated: false)
    }
    
    func goToCities() {
        let citiesCoordinator = CitiesCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(citiesCoordinator)
        citiesCoordinator.start()
    }
    
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    deinit {
        print("WeatherCoordinator deinit")
    }
    
}
