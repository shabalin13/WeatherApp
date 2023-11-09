//
//  SquareCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 06.11.2023.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SquareCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(feelsTemperatureItem: FeelsTemperatureItem) {
        self.backgroundColor = .yellow.withAlphaComponent(0.5)
    }
    
    func configureCell(visibilityItem: VisibilityItem) {
        self.backgroundColor = .red.withAlphaComponent(0.5)
    }
    
    func configureCell(sunItem: SunItem) {
        self.backgroundColor = .green.withAlphaComponent(0.5)
    }
    
    func configureCell(humidityItem: HumidityItem) {
        self.backgroundColor = .purple.withAlphaComponent(0.5)
    }
    
    func configureCell(pressureItem: PressureItem) {
        self.backgroundColor = .brown.withAlphaComponent(0.5)
    }
    
    func configureCell(precipitationItem: PrecipitationItem) {
        self.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
}
