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
//        headerView.backgroundColor = .red.withAlphaComponent(0.5)
        
        return headerView
    }()
    
    private lazy var mainView: SquareItemMainView = {
        let mainView = SquareItemMainView()
//        mainView.backgroundColor = .black.withAlphaComponent(0.5)
        
        return mainView
    }()
    
    private lazy var footerView: SquareItemFooterView = {
        let footerView = SquareItemFooterView()
//        footerView.backgroundColor = .yellow.withAlphaComponent(0.5)
        
        return footerView
    }()
    
    static let reuseIdentifier = "SquareCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        
        contentView.addSubview(headerView)
        contentView.addSubview(mainView)
        contentView.addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 38),
            
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            mainView.bottomAnchor.constraint(lessThanOrEqualTo: footerView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            footerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(squareItemIdentifier: SquareItemIdentifier) {
        switch squareItemIdentifier {
        case .feelsTemperature(let feelsTemperatureItem):
            headerView.configureHeader(imageName: "thermometer.medium", titleName: "Feels like")
            footerView.configureFooter(description: feelsTemperatureItem.descriptionString)
            mainView.configureView(feelsTemperatureItem: feelsTemperatureItem)
        case .visibility(let visibilityItem):
            headerView.configureHeader(imageName: "eye.fill", titleName: "Visibility")
            footerView.configureFooter(description: visibilityItem.descriptionString)
            mainView.configureCell(visibilityItem: visibilityItem)
        case .humidity(let humidityItem):
            headerView.configureHeader(imageName: "humidity.fill", titleName: "Humidity")
            footerView.configureFooter(description: humidityItem.dewTemperatureString ?? "")
            mainView.configureCell(humidityItem: humidityItem)
        case .precipitation(let precipitationItem):
            headerView.configureHeader(imageName: "drop.fill", titleName: "Precipitation")
            footerView.configureFooter(description: precipitationItem.expectedPrecipitationString)
            mainView.configureCell(precipitationItem: precipitationItem)
        case .sun(let sunItem):
            headerView.configureHeader(imageName: "sunrise.fill", titleName: "Sunrise")
            footerView.configureFooter(description: sunItem.sunsetTimeString)
            mainView.configureCell(sunItem: sunItem)
        case .pressure(let pressureItem):
            headerView.configureHeader(imageName: "gauge.medium", titleName: "Pressure")
            footerView.configureFooter(description: "")
            mainView.configureCell(pressureItem: pressureItem)
        }
    }
    
}
