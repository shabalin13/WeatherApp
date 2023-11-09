//
//  WeatherSectionHeaderView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

import UIKit

class WeatherSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "WeatherSectionHeaderView"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .red.withAlphaComponent(0.5)
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .yellow.withAlphaComponent(0.3)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            stackView.topAnchor.constraint(equalTo: self.topAnchor),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
//            imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureHeader(imageName: String, titleName: String) {
        imageView.image = UIImage(systemName: imageName)?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        titleLabel.text = titleName.uppercased()
    }
    
}
