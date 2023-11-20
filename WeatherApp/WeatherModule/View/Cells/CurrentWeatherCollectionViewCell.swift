//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 16.11.2023.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
        
    static let reuseIdentifier = "CurrentWeatherCollectionViewCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        
//        stackView.backgroundColor = .yellow.withAlphaComponent(0.5)
        
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 28, weight: .medium)
        
//        label.backgroundColor = .red.withAlphaComponent(0.5)
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 70, weight: .regular)
        
//        label.backgroundColor = .red.withAlphaComponent(0.5)
        
        return label
    }()
    
    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
//        label.backgroundColor = .red.withAlphaComponent(0.5)
        
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

        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherDescriptionLabel)
        
        contentView.addSubview(stackView)
//        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalOffset: CGFloat = 0
        let verticalOffset: CGFloat = 0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
        ])
    }
    
    func configureCell(currentWeatherItem: CurrentWeatherItem) {
        cityLabel.text = currentWeatherItem.cityName
        temperatureLabel.text = currentWeatherItem.temperatureString
        weatherDescriptionLabel.text = currentWeatherItem.weatherDescription
    }
    
}
