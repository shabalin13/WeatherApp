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
    func getCitiesInfo(cityName: String, userLocation: (latitude: Double, longitude: Double), completionHandler: @escaping (Swift.Result<CitiesInfo, Error>) -> Void)
    
}

final class NetworkService: NetworkServiceProtocol {
   
    enum NetworkServiceError: Error, LocalizedError {
        case getCurrentWeatherFailed
        case getHourlyForecastsInfoFailed
        case getDailyForecastsInfoFailed
        case getMapsAccessTokenFailed
        case getCitiesInfoFailed
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
    
    private func getMapsAccessToken(completionHandler: @escaping (Swift.Result<MapsAccessToken, Error>) -> Void) {
        AF.request(NetworkRouter.mapsAccessToken).validate().responseDecodable(of: MapsAccessToken.self) { response in
            switch response.result {
            case .success(let mapsAccessToken):
                print(mapsAccessToken)
                completionHandler(.success(mapsAccessToken))
            case .failure(_):
                completionHandler(.failure(NetworkServiceError.getMapsAccessTokenFailed))
            }
        }
    }
    
    func getCitiesInfo(cityName: String, userLocation: (latitude: Double, longitude: Double), completionHandler: @escaping (Result<CitiesInfo, Error>) -> Void) {
        getMapsAccessToken { result in
            switch result {
            case .success(let mapsAccessToken):
                AF.request(NetworkRouter.citiesInfo(mapsAccessToken: mapsAccessToken, cityName: cityName, userLocation: userLocation)).validate().responseDecodable(of: CitiesInfo.self) { response in
                    switch response.result {
                    case .success(let citiesInfo):
                        completionHandler(.success(citiesInfo))
                    case .failure(_):
                        completionHandler(.failure(NetworkServiceError.getCitiesInfoFailed))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
