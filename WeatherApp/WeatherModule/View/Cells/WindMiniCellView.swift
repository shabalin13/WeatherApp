//
//  WindMiniCellView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 09.11.2023.
//

import UIKit

class WindMiniView: UIView {
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35)
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var windUnitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var windNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.addArrangedSubview(windUnitLabel)
        stackView.addArrangedSubview(windNameLabel)
        
        addSubview(windLabel)
        addSubview(stackView)
        
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            windLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            windLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            stackView.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            windLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            windSpeedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
//            stackView.heightAnchor.constraint(equalTo: windSpeedLabel.heightAnchor, multiplier: 1),
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureView(wind: String, windName: String, windUnit: String) {
        windLabel.text = wind
        windNameLabel.text = windName
        windUnitLabel.text = windUnit
    }
    
}
