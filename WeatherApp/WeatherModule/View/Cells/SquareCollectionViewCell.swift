//
//  SquareCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 06.11.2023.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
    
    private lazy var headerView: SquareItemHeaderView = {
        let headerView = SquareItemHeaderView()
        
        return headerView
    }()
    
    static let reuseIdentifier = "SquareCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        
        addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(feelsTemperatureItem: FeelsTemperatureItem) {
        headerView.configureHeader(imageName: "thermometer.medium", titleName: "Feels like")
//        self.backgroundColor = .yellow.withAlphaComponent(0.5)
    }
    
    func configureCell(visibilityItem: VisibilityItem) {
        headerView.configureHeader(imageName: "eye.fill", titleName: "Visibility")
//        self.backgroundColor = .red.withAlphaComponent(0.5)
    }
    
    func configureCell(sunItem: SunItem) {
        headerView.configureHeader(imageName: "sunrise.fill", titleName: "Sunrise")
//        self.backgroundColor = .green.withAlphaComponent(0.5)
    }
    
    func configureCell(humidityItem: HumidityItem) {
        headerView.configureHeader(imageName: "humidity.fill", titleName: "Humidity")
//        self.backgroundColor = .purple.withAlphaComponent(0.5)
    }
    
    func configureCell(pressureItem: PressureItem) {
        headerView.configureHeader(imageName: "gauge.medium", titleName: "Pressure")
//        self.backgroundColor = .brown.withAlphaComponent(0.5)
    }
    
    func configureCell(precipitationItem: PrecipitationItem) {
        headerView.configureHeader(imageName: "drop.fill", titleName: "Precipitation")
//        self.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
}
