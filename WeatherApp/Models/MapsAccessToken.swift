//
//  MapsAccessToken.swift
//  WeatherApp
//
//  Created by DIMbI4 on 27.11.2023.
//

struct MapsAccessToken: Decodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "accessToken"
    }
    
}
