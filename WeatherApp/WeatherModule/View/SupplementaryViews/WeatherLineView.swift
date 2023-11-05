//
//  WeatherLineView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

class WeatherLineView: UICollectionReusableView {
    
    static let reuseIdentifier = "WeatherLineView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .lightGray
        self.backgroundColor = .black
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func setColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
}
