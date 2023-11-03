//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModelProtocol
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Weather"
        self.view.backgroundColor = .systemBackground
        
        setupToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getWeather()
    }
    
    private func setupToolBar() {
        self.navigationController?.isToolbarHidden = false
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: nil)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .plain, target: self, action: #selector(goToCities))
        )
        
        self.toolbarItems = items
    }
    
    @objc func goToCities() {
        self.viewModel.goToCities()
    }
    
    deinit {
        print("WeatherViewController deinit")
    }

}
