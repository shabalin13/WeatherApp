//
//  CityWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 20.11.2023.
//

import UIKit

class CityWeatherCollectionViewCell: UICollectionViewCell {
        
    static let reuseIdentifier = "CityWeatherCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private func setupView() {

        contentView.backgroundColor = .yellow.withAlphaComponent(0.5)
    }
    
    func configureCell(cityWeatherItem: CityWeatherItem) {
        
    }
    
}
