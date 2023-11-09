//
//  WindCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

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
            
//            imageView.leadingAnchor.constraint(equalTo: firstWindMiniCell.trailingAnchor, constant: 5),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            
            lineView.leadingAnchor.constraint(equalTo: firstWindMiniCell.leadingAnchor),
            lineView.topAnchor.constraint(equalTo: firstWindMiniCell.bottomAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: firstWindMiniCell.trailingAnchor),
            
            secondWindMiniCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            secondWindMiniCell.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            secondWindMiniCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
//            firstWindMiniCell.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
//            secondWindMiniCell.widthAnchor.constraint(equalTo: firstWindMiniCell.widthAnchor, multiplier: 1),
            firstWindMiniCell.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
            secondWindMiniCell.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
            secondWindMiniCell.heightAnchor.constraint(equalTo: firstWindMiniCell.heightAnchor, multiplier: 1),
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(windItem: WindItem) {
        firstWindMiniCell.configureCell(windSpeed: windItem.speed, windName: "Wind", windUnit: "m/s")
        secondWindMiniCell.configureCell(windSpeed: windItem.gust, windName: "Gust", windUnit: "m/s")
        imageView.image = UIImage(systemName: "safari")
        imageView.tintColor = .black
    }
}
