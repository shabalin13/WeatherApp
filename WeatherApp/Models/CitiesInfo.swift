//
//  CitiesInfo.swift
//  WeatherApp
//
//  Created by DIMbI4 on 27.11.2023.
//

struct CitiesInfo: Decodable {
    
    let results: [CityInfo]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
