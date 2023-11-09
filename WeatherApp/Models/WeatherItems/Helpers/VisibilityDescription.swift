//
//  VisibilityDescription.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

enum VisibilityDescription: Hashable {
    
    case clear
    case fairlyClear
    case moderate
    case poor
    case veryPoor
    case undefined
    
    init(visibility: Int) {
        switch visibility {
        case 10_000...Int.max:
            self = .clear
        case 2_000..<10_000:
            self = .fairlyClear
        case 500..<2_000:
            self = .moderate
        case 200..<500:
            self = .poor
        case 0..<200:
            self = .veryPoor
        default:
            self = .undefined
        }
    }
    
    var description: String {
        switch self {
        case .clear:
            return "Clear view"
        case .fairlyClear:
            return "Fairly clear view"
        case .moderate:
            return "Moderate view"
        case .poor:
            return "Poor view"
        case .veryPoor:
            return "Very poor view"
        case .undefined:
            return "Undefined"
        }
    }
    
}
