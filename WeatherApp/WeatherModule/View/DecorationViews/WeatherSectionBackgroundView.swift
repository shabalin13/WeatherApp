//
//  WeatherSectionBackgroundView.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit

class WeatherSectionBackgroundView: UICollectionReusableView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 46/255, green: 51/255, blue: 90/255, alpha: 0.5)
        self.layer.cornerRadius = 20
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
}
