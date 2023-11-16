//
//  WindCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "WindCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var firstWindMiniView: WindMiniView = {
        let view = WindMiniView()
        
        return view
    }()
    
    private lazy var secondWindMiniView: WindMiniView = {
        let view = WindMiniView()
        
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
//        view.backgroundColor = .lightGray
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(firstWindMiniView)
        addSubview(lineView)
        addSubview(secondWindMiniView)
        addSubview(imageView)
        
        firstWindMiniView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        secondWindMiniView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstWindMiniView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            firstWindMiniView.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            
            lineView.leadingAnchor.constraint(equalTo: firstWindMiniView.leadingAnchor),
            lineView.topAnchor.constraint(equalTo: firstWindMiniView.bottomAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: firstWindMiniView.trailingAnchor),
            
            secondWindMiniView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            secondWindMiniView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            secondWindMiniView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            firstWindMiniView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
            secondWindMiniView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
            secondWindMiniView.heightAnchor.constraint(equalTo: firstWindMiniView.heightAnchor, multiplier: 1),
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(windItem: WindItem) {
        firstWindMiniView.configureView(wind: windItem.speedString, windName: "Wind", windUnit: windItem.unitsString)
        secondWindMiniView.configureView(wind: windItem.gustString, windName: "Gust", windUnit: windItem.unitsString)
        imageView.image = UIImage(systemName: "safari")
        imageView.tintColor = .black
    }
}
