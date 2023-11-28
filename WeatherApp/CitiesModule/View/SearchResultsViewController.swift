//
//  SearchResultsViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 20.11.2023.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityItemCell")
        
        return tableView
    }()
    
    private lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let vertivalOffset: CGFloat = 0
        let horizontalOffset: CGFloat = 0
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalOffset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalOffset),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: vertivalOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -vertivalOffset),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func createDataSource() -> UITableViewDiffableDataSource<Int, CityItem> {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityItemCell", for: indexPath)
            cell.textLabel?.text = itemIdentifier.cityName
            return cell
        })
        return dataSource
    }
    
    func updateView(cityItems: CityItems) {
        createSnapshot(cityItems: cityItems)
    }
    
    func createSnapshot(cityItems: CityItems) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CityItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(cityItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SearchResultsViewController deinit")
    }
    
}
