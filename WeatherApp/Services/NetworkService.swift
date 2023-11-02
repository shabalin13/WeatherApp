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
    func getHourlyForecastsInfo(cityName: String, hoursCount: Int, completionHandler: @escaping (Swift.Result<HourlyForecastsInfo, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
   
    enum NetworkServiceError: Error, LocalizedError {
        case getCurrentWeatherFailed
        case getHourlyForecastsInfoFailed
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
    
    func getHourlyForecastsInfo(cityName: String, hoursCount: Int, completionHandler: @escaping (Result<HourlyForecastsInfo, Error>) -> Void) {
        AF.request(NetworkRouter.hourlyForecastsInfo(cityName: cityName, hoursCount: hoursCount)).validate().responseDecodable(of: HourlyForecastsInfo.self) { response in
            switch response.result {
            case .success(let hourlyForecastsInfo):
                completionHandler(.success(hourlyForecastsInfo))
            case .failure(_):
                completionHandler(.failure(NetworkServiceError.getHourlyForecastsInfoFailed))
            }
        }
    }
    
}
