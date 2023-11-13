//
//  SquareItemFooterView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 13.11.2023.
//

import UIKit

class SquareItemFooterView: UIView {

    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
        addSubview(footerLabel)
        
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        let verticalOffset: CGFloat = 0
        let horizontalOffset: CGFloat = 20
        NSLayoutConstraint.activate([
            footerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            footerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
            footerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            footerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
        ])
    }
    
    func configureFooter(description: String) {
        footerLabel.text = description
    }

}
