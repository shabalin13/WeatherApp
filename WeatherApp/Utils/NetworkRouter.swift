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
    
    var baseURL: URL {
        switch self {
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org")!
        }
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "data/2.5/weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather:
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
        }
    }
    
}

extension NetworkRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        
        return request
    }
    
}
