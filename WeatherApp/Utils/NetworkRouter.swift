//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import Foundation
import Alamofire

enum NetworkRouter {
    
    case currentWeather(cityName: String)
    case hourlyForecastsInfo(cityName: String, hoursCount: Int)
    
    var baseURL: URL {
        switch self {
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org")!
        case .hourlyForecastsInfo:
            return URL(string: "https://pro.openweathermap.org")!
        }
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "data/2.5/weather"
        case .hourlyForecastsInfo:
            return "data/2.5/forecast/hourly"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather, .hourlyForecastsInfo:
            return .get
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .currentWeather(let cityName):
            return ["q": cityName,
                    "lang": Constants.NetworkServiceConstants.lang,
                    "units": Constants.NetworkServiceConstants.units,
                    "appid": Constants.NetworkServiceConstants.APIkey]
        case .hourlyForecastsInfo(let cityName, let hoursCount):
            return ["q": cityName,
                    "cnt": String(hoursCount),
                    "lang": Constants.NetworkServiceConstants.lang,
                    "units": Constants.NetworkServiceConstants.units,
                    "appid": Constants.NetworkServiceConstants.APIkey]
        }
    }
    
}

extension NetworkRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        
        print(request)
        
        return request
    }
    
}
