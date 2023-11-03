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
    func getDailyForecastsInfo(cityName: String, daysCount: Int, completionHandler: @escaping (Swift.Result<DailyForecastsInfo, Error>) -> Void)
    
}

final class NetworkService: NetworkServiceProtocol {
   
    enum NetworkServiceError: Error, LocalizedError {
        case getCurrentWeatherFailed
        case getHourlyForecastsInfoFailed
        case getDailyForecastsInfoFailed
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
    
    func getDailyForecastsInfo(cityName: String, daysCount: Int, completionHandler: @escaping (Result<DailyForecastsInfo, Error>) -> Void) {
        AF.request(NetworkRouter.dailyForecastsInfo(cityName: cityName, daysCount: daysCount)).validate().responseDecodable(of: DailyForecastsInfo.self) { response in
            switch response.result {
            case .success(let dailyForecastsInfo):
                completionHandler(.success(dailyForecastsInfo))
            case .failure(_):
                completionHandler(.failure(NetworkServiceError.getDailyForecastsInfoFailed))
            }
        }
    }
    
}
