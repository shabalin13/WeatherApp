//
//  SquareItemHeaderView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 09.11.2023.
//

import UIKit

class SquareItemHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        
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
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let verticalOffset: CGFloat = 0
        let horizontalOffset: CGFloat = 15
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
        ])
    }
    
    func configureHeader(imageName: String, titleName: String) {
        let titleString = NSMutableAttributedString()
        
        let color = UIColor.secondaryLabel
        let font = UIFont.systemFont(ofSize: 13)
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        let textString = NSAttributedString(string: " \(titleName.uppercased())", attributes: textAttributes)

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageString = NSAttributedString(attachment: imageAttachment)

        titleString.append(imageString)
        titleString.append(textString)

        titleLabel.attributedText = titleString
    }

}
