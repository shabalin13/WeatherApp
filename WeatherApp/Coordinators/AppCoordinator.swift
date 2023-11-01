//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("AppCoordinator Start")
        
        let navigationController = UINavigationController()
        
        let weatherCoordinator = WeatherCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(weatherCoordinator)
        weatherCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    deinit {
        print("AppCoordinator deinit")
    }
    
}
