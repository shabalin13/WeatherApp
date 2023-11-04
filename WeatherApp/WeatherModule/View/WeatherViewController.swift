//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit
import RxSwift

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModelProtocol
    
    private enum Section: Hashable {
        case main
        case hourlyForecasts
        case dailyForecasts
        case wind
        case sun
        case feelsTemperature
        case precipitation
        case visibility
        case humidity
        case pressure
    }
    
    private var sections = [Section]()
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    let disposeBag = DisposeBag()
    
    // MARK: Inits
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    

    // MARK: view life functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Weather"
        self.view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureDataSource()
        
        setupToolBar()
        
        subscribe()
    }
    
    private func subscribe() {
        viewModel.weatherItem.subscribe(onNext: { weatherItem in
//            self.navigationItem.title = "\(weather.temperature)"
            self.createSnapshot(weatherItem: weatherItem)
        })
        .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getWeather()
    }
    
    
    // MARK: CollectionView functions
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section {
            case .hourlyForecasts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
                return section
            default:
                return nil
            }
        }
        return layout
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            if let hourlyForecastItem = item as? HourlyForecastItem {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyForecastCollectionViewCell
                
                cell.configureCell(hourlyForecastItem: hourlyForecastItem)
                return cell
            } else {
                fatalError("No such ItemIdentifierType")
            }
            
//            let section = self.sections[indexPath.section]
//            switch section {
//            case .hourlyForecasts:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyForecastCollectionViewCell
//                
//                cell.configureCell(hourlyForecastItem: <#T##HourlyForecastItem#>)
//                return cell
//            default:
//                fatalError("Not yet implemented")
//            }
        })
        
//        createSnapshot()
    }
    
    private func createSnapshot(weatherItem: WeatherItem) {
//        if let weatherItem = viewModel.weatherItem {
//            var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
//            snapshot.appendSections([.hourlyForecasts])
//
////            let weatherItems = hourlyForecastItems.map { hourlyForecastItem in
////                WeatherItem.hourlyForecast(hourlyForecastItem)
////            }
//            
//            snapshot.appendItems(weatherItem.hourlyForecastItems, toSection: .hourlyForecasts)
//            sections = snapshot.sectionIdentifiers
//            
//            dataSource.apply(snapshot, animatingDifferences: true)
//        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.hourlyForecasts])
        
        snapshot.appendItems(weatherItem.hourlyForecastItems, toSection: .hourlyForecasts)
        sections = snapshot.sectionIdentifiers
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Toolbar
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
    
    // MARK: objc action functions
    @objc func goToCities() {
        self.viewModel.goToCities()
    }
    
    // MARK: deinit
    deinit {
        print("WeatherViewController deinit")
    }

}
