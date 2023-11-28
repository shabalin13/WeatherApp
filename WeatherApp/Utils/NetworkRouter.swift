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
    case dailyForecastsInfo(cityName: String, daysCount: Int)
    case mapsAccessToken
    case citiesInfo(mapsAccessToken: MapsAccessToken, cityName: String, userLocation: (latitude: Double, longitude: Double))
    
    var baseURL: URL {
        switch self {
        case .currentWeather, .dailyForecastsInfo:
            return URL(string: "https://api.openweathermap.org")!
        case .hourlyForecastsInfo:
            return URL(string: "https://pro.openweathermap.org")!
        case .mapsAccessToken, .citiesInfo:
            return URL(string: "https://maps-api.apple.com")!
        }
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "data/2.5/weather"
        case .hourlyForecastsInfo:
            return "data/2.5/forecast/hourly"
        case .dailyForecastsInfo:
            return "data/2.5/forecast/daily"
        case .mapsAccessToken:
            return "v1/token"
        case .citiesInfo:
            return "v1/searchAutocomplete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather, .hourlyForecastsInfo, .dailyForecastsInfo:
            return .get
        case .mapsAccessToken, .citiesInfo:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .currentWeather, .hourlyForecastsInfo, .dailyForecastsInfo:
            return nil
        case .mapsAccessToken:
            return ["Authorization": "Bearer \(Constants.NetworkServiceConstants.jwtToken)"]
        case .citiesInfo(let mapsAccessToken, _, _):
            return ["Authorization": "Bearer \(mapsAccessToken.token)"]
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
        case .dailyForecastsInfo(let cityName, let daysCount):
            return ["q": cityName,
                    "cnt": String(daysCount),
                    "lang": Constants.NetworkServiceConstants.lang,
                    "units": Constants.NetworkServiceConstants.units,
                    "appid": Constants.NetworkServiceConstants.APIkey]
        case .mapsAccessToken:
            return [:]
        case .citiesInfo(_, let cityName, let userLocation):
            return ["q": cityName,
                    "userLocation": "\(userLocation.latitude),\(userLocation.longitude)",
                    "lang": Constants.NetworkServiceConstants.lang,
                    "includePoiCategories": Constants.NetworkServiceConstants.includePoiCategories,
                    "resultTypeFilter": Constants.NetworkServiceConstants.resultTypeFilter]
        }
    }
    
}

extension NetworkRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        
//        print(request)
        
        return request
    }
    
}
