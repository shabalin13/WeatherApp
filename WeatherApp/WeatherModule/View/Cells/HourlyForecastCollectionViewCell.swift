//
//  HourlyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 03.11.2023.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ForecastCollectionViewCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
//        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
//        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 30
        contentView.layer.borderWidth = 1
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(temperatureLabel)
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(hourlyForecastItem: HourlyForecastItem) {
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyForecastItem.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: hourlyForecastItem.timezone)
        dateLabel.text = dateFormatter.string(from: date)
        
        imageView.image = UIImage(named: hourlyForecastItem.iconName)
        
        temperatureLabel.text = "\(hourlyForecastItem.temperature)°"
    }
    
}
