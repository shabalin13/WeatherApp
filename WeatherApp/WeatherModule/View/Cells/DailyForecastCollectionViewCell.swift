//
//  DailyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

class DailyForecastCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DailyForecastCollectionViewCellr"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var temperatureMinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var temperatureBar: UIProgressView = {
        let progressView = UIProgressView()
        
        return progressView
    }()
    
    private lazy var temperatureMaxLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        addSubview(dateLabel)
        addSubview(imageView)
        addSubview(temperatureMinLabel)
        addSubview(temperatureBar)
        addSubview(temperatureMaxLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureMinLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureBar.translatesAutoresizingMaskIntoConstraints = false
        temperatureMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureMaxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            temperatureBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            temperatureMinLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.dateLabel.trailingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1),
            temperatureMinLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            temperatureMinLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 15),
            temperatureBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            temperatureBar.leadingAnchor.constraint(equalTo: self.temperatureMinLabel.trailingAnchor, constant: 15),
            temperatureMaxLabel.leadingAnchor.constraint(equalTo: self.temperatureBar.trailingAnchor, constant: 15),
            temperatureMaxLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(dailyForecastItem: DailyForecastItem) {
        let date = Date(timeIntervalSince1970: TimeInterval(dailyForecastItem.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: dailyForecastItem.timezone)
        dateLabel.text = dateFormatter.string(from: date)
        
        temperatureMinLabel.text = String(dailyForecastItem.temperatureMin)
        temperatureMaxLabel.text = String(dailyForecastItem.temperatureMax)
        
        imageView.image = UIImage(named: dailyForecastItem.iconName)
    }
}
