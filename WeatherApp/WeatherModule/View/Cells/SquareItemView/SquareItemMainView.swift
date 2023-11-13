//
//  SquareItemMainView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 13.11.2023.
//

import UIKit

class SquareItemMainView: UIView {

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private func setupView() {
        addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let verticalOffset: CGFloat = 0
        let horizontalOffset: CGFloat = 20
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
        ])
    }
    
    func configureView(feelsTemperatureItem: FeelsTemperatureItem) {
        mainLabel.text = feelsTemperatureItem.feelsTemperatureString
    }
    
    func configureCell(visibilityItem: VisibilityItem) {
        mainLabel.text = visibilityItem.visibilityString
    }
    
    func configureCell(humidityItem: HumidityItem) {
        mainLabel.text = humidityItem.humidityString
    }
    
    func configureCell(precipitationItem: PrecipitationItem) {
        mainLabel.text = precipitationItem.precipitationString + " " + precipitationItem.precipitationAdditionalString
    }
    
    func configureCell(sunItem: SunItem) {
        mainLabel.text = sunItem.sunriseTimeString
    }
    
    func configureCell(pressureItem: PressureItem) {
        mainLabel.text = pressureItem.mmHgPressureString + " " + "mm Hg"
    }

}
