//
//  HourlyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 03.11.2023.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HourlyForecastCollectionViewCell"
    
    private lazy var biggerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var smallerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var probabilityOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        
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
        contentView.backgroundColor = .white.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 30
        contentView.layer.borderWidth = 1
        
        smallerStackView.addArrangedSubview(imageView)
        smallerStackView.addArrangedSubview(probabilityOfPrecipitationLabel)
        
        biggerStackView.addArrangedSubview(dateLabel)
        biggerStackView.addArrangedSubview(smallerStackView)
        biggerStackView.addArrangedSubview(temperatureLabel)
        
        contentView.addSubview(biggerStackView)
        
        biggerStackView.translatesAutoresizingMaskIntoConstraints = false
        let verticalOffset: CGFloat = 16
        let horizontalOffset: CGFloat = 8
        NSLayoutConstraint.activate([
            biggerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalOffset),
            biggerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalOffset),
            biggerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalOffset),
            biggerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalOffset),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])
    }
    
    func configureCell(hourlyForecastItem: HourlyForecastItem) {
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyForecastItem.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: hourlyForecastItem.timezone)
        dateLabel.text = dateFormatter.string(from: date)
        
        imageView.image = UIImage(named: hourlyForecastItem.iconName)
        
        if hourlyForecastItem.probabilityOfPrecipitation == 0 {
            probabilityOfPrecipitationLabel.text = " "
        } else {
            probabilityOfPrecipitationLabel.text = "\(hourlyForecastItem.probabilityOfPrecipitation) %"
        }
        
        temperatureLabel.text = "\(hourlyForecastItem.temperature)°"
    }
    
}
