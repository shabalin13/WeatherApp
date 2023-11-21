//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit

class CitiesViewController: UIViewController {
    
    private var viewModel: CitiesViewModelProtocol
    
    private lazy var searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    private lazy var collectionView = createCollectionView()
    private lazy var dataSource = createDataSource()
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        createSnapshot(cityWeatherItems: [CityWeatherItem(isCurrentCity: true, cityName: "Kazan", temperature: -4, weatherName: "Snow", temperatureMin: -9, temperatureMax: -2)])
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBlue
        
        setupNavigationBar()
        setupToolbar()
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Cities"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(comeBackFromCities))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
    }
    
    private func setupToolbar() {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBlue
        
        collectionView.register(CityWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CityWeatherCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewHorizontalOffset: CGFloat = 20
        let collectionViewVerticalOffset: CGFloat = 0
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: collectionViewHorizontalOffset),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -collectionViewHorizontalOffset),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: collectionViewVerticalOffset),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewVerticalOffset)
        ])
        
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<CitiesSectionIdentifier, CitiesItemIdentifier> {
        
        let dataSource = UICollectionViewDiffableDataSource<CitiesSectionIdentifier, CitiesItemIdentifier>.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! CityWeatherCollectionViewCell
            cell.configureCell(cityWeatherItem: itemIdentifier.cityWeather!)
            return cell
        }
        
        return dataSource
    }
    
    private func createSnapshot(cityWeatherItems: [CityWeatherItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<CitiesSectionIdentifier, CitiesItemIdentifier>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(cityWeatherItems.map({ CitiesItemIdentifier.cityWeather($0) }))
        
        dataSource.apply(snapshot)
    }
    
    @objc func comeBackFromCities() {
        viewModel.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewController deinit")
    }
    
}


extension CitiesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "nil")
    }
    
}
