//
//  Coordinator.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    func start()
    
}
