//
//  VisibilityItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 08.11.2023.
//

struct VisibilityItem: Hashable {
    
    private let visibility: Int
    private var description: VisibilityDescription {
        return .init(visibility: visibility)
    }
    
    init(visibility: Int) {
        self.visibility = visibility
    }
    
    var visibilityString: String {
        if case .clear = description {
            return ">10 km"
        } else if visibility < 1000 {
            return "\(visibility) m"
        } else {
            let visibility = Int((Double(visibility) / 1000).rounded())
            return "\(visibility) km"
        }
    }
    
    var descriptionString: String {
        return description.description
    }
    
}
