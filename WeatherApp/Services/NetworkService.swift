//
//  NetworkService.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getCurrentWeather(cityName: String, completionHandler: @escaping (Swift.Result<CurrentWeather, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
   
    enum NetworkServiceError: Error, LocalizedError {
        case getCurrentWeatherFailed
    }
    
    func getCurrentWeather(cityName: String, completionHandler: @escaping (Result<CurrentWeather, Error>) -> Void) {
        AF.request(NetworkRouter.currentWeather(cityName: cityName)).validate().responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                completionHandler(.success(currentWeather))
            case .failure(_):
                completionHandler(.failure(NetworkServiceError.getCurrentWeatherFailed))
            }
        }
    }
    
}
