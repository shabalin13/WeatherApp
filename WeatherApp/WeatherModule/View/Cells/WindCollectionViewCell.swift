//
//  WindCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

class WindMiniCellView: UIView {
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35)
        label.numberOfLines = 1
        label.textAlignment = .right
        
//        label.backgroundColor = .blue
        
        return label
    }()
    
    lazy var windUnitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
//        label.textAlignment = .left
        
//        label.backgroundColor = .green
        
        return label
    }()
    
    lazy var windNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
//        label.textAlignment = .left
        
//        label.backgroundColor = .yellow
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
//        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.addArrangedSubview(windUnitLabel)
        stackView.addArrangedSubview(windNameLabel)
        
        addSubview(windSpeedLabel)
        addSubview(stackView)
        
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            windSpeedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            windSpeedLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            stackView.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            windSpeedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            windSpeedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
//            stackView.heightAnchor.constraint(equalTo: windSpeedLabel.heightAnchor, multiplier: 1),
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(windSpeed: Int, windName: String, windUnit: String) {
        windSpeedLabel.text = String(windSpeed)
        windNameLabel.text = windName
        windUnitLabel.text = windUnit
    }
    
}

class WindCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "WindCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var firstWindMiniCell: WindMiniCellView = {
        let cell = WindMiniCellView()
        
        return cell
    }()
    
    lazy var secondWindMiniCell: WindMiniCellView = {
        let cell = WindMiniCellView()
        
        return cell
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
//        view.backgroundColor = .lightGray
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(firstWindMiniCell)
        addSubview(lineView)
        addSubview(secondWindMiniCell)
        addSubview(imageView)
        
        firstWindMiniCell.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        secondWindMiniCell.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        backgroundColor = .brown.withAlphaComponent(0.3)
//        firstWindMiniCell.backgroundColor = .red.withAlphaComponent(0.3)
//        secondWindMiniCell.backgroundColor = .blue.withAlphaComponent(0.3)
//        imageView.backgroundColor = .orange.withAlphaComponent(0.3)
        
        NSLayoutConstraint.activate([
            firstWindMiniCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            firstWindMiniCell.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: firstWindMiniCell.trailingAnchor, constant: 5),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            
            lineView.leadingAnchor.constraint(equalTo: firstWindMiniCell.leadingAnchor),
            lineView.topAnchor.constraint(equalTo: firstWindMiniCell.bottomAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: firstWindMiniCell.trailingAnchor),
            
            secondWindMiniCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            secondWindMiniCell.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            secondWindMiniCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            firstWindMiniCell.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            secondWindMiniCell.widthAnchor.constraint(equalTo: firstWindMiniCell.widthAnchor, multiplier: 1),
            secondWindMiniCell.heightAnchor.constraint(equalTo: firstWindMiniCell.heightAnchor, multiplier: 1),
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(currentWeatherItem: CurrentWeatherItem) {
        firstWindMiniCell.configureCell(windSpeed: Int(currentWeatherItem.windSpeed.rounded()), windName: "Wind", windUnit: "m/s")
        secondWindMiniCell.configureCell(windSpeed: Int(currentWeatherItem.windGust.rounded()), windName: "Gust", windUnit: "m/s")
        imageView.image = UIImage(systemName: "safari")
        imageView.tintColor = .black
    }
}
