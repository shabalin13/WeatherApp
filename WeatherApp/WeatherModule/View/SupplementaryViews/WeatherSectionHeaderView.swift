//
//  WeatherSectionHeaderView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 04.11.2023.
//

import UIKit

class WeatherSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "WeatherSectionHeaderView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureHeader(imageName: String, titleName: String) {
        let titleString = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        let imageString = NSAttributedString(attachment: imageAttachment)
        titleString.append(imageString)
        titleString.append(NSAttributedString(string: " \(titleName.uppercased())"))
        
        titleLabel.attributedText = titleString
    }
    
}
