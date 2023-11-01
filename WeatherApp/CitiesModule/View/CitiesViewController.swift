//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit

class CitiesViewController: UIViewController {

    private var viewModel: CitiesViewModelProtocol
    
    init(viewModel: CitiesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Cities"
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(comeBackFromCities))
    }
    
    @objc func comeBackFromCities() {
        viewModel.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewController deinit")
    }

}
