//
//  PrecipitationItem.swift
//  WeatherApp
//
//  Created by DIMbI4 on 09.11.2023.
//

struct PrecipitationItem: Hashable {
    
    private let precipitation: Int
    private let expectedPrecipitation: ExpectedPrecipitation
    
    init(precipitation: Int, expectedPrecipitation: ExpectedPrecipitation) {
        self.precipitation = precipitation
        self.expectedPrecipitation = expectedPrecipitation
    }
    
    var precipitationString: String {
        return "\(precipitation) mm"
    }
    
    var precipitationAdditionalString: String {
        return "in last hour"
    }
    
    var expectedPrecipitationString: String {
        return expectedPrecipitation.description
    }
    
}
