//
//  CityInfo.swift
//  WeatherApp
//
//  Created by DIMbI4 on 27.11.2023.
//

struct CityInfo {
    
    let displayLines: [String]
    let location: (latitude: Double, longitude: Double)
    
    enum RootKeys: String, CodingKey {
        case displayLines
        case location
    }
    
    enum LocationKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
}

extension CityInfo: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        displayLines = try container.decode([String].self, forKey: .displayLines)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        let latitude = try locationContainer.decode(Double.self, forKey: .latitude)
        let longitude = try locationContainer.decode(Double.self, forKey: .longitude)
        location = (latitude, longitude)
        
    }
}
