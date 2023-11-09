//
//  VisibilityItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

struct VisibilityItem: Hashable {
    
    let visibility: Int
    var description: VisibilityDescription {
        return .init(visibility: visibility)
    }
    
}
