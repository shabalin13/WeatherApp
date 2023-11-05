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
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<WeatherSectionIdentifier, WeatherItemIdentifier>!
    
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
        
        subscribe()
        
        setupToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getWeather()
    }
    
    // MARK: RxSwift subsription
    private func subscribe() {
        viewModel.weatherItem.subscribe(onNext: { weatherItem in
            self.createSnapshot(weatherItem: weatherItem)
        })
        .disposed(by: disposeBag)
        
    }
    
    
    // MARK: CollectionView functions
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(WeatherSectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: WeatherSectionHeaderView.reuseIdentifier)
        collectionView.register(WeatherLineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.line, withReuseIdentifier: WeatherLineView.reuseIdentifier)
        
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier)
        collectionView.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: DailyForecastCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.viewModel.sections[sectionIndex]
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
//            headerItem.pinToVisibleBounds = true
            
            let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
            let lineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(lineItemHeight))
            let lineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.line, alignment: .top)
            lineItem.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            switch section {
            case .hourlyForecasts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 5)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.boundarySupplementaryItems = [lineItem, headerItem]
                
                let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewKind.background)
                section.decorationItems = [sectionBackground]
                
                return section
            case .dailyForecasts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 5)
//                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [lineItem, headerItem]
                
                let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewKind.background)
                section.decorationItems = [sectionBackground]
                return section
            default:
                return nil
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        layout.register(WeatherSectionBackgroundView.self, forDecorationViewOfKind: DecorationViewKind.background)
        
        return layout
    }
    
    private func configureDataSource() {
        
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = self.viewModel.sections[indexPath.section]
            switch section {
            case .hourlyForecasts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyForecastCollectionViewCell
                cell.configureCell(hourlyForecastItem: itemIdentifier.hourlyForecast!)
                
                return cell
            case .dailyForecasts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! DailyForecastCollectionViewCell
                cell.configureCell(dailyForecastItem: itemIdentifier.dailyForecast!)
                
                return cell
            default:
                return nil
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            let section = self.viewModel.sections[indexPath.section]
            let sectionImageName: String
            let sectionTitleName: String
            
            switch section {
            case .hourlyForecasts(let imageName, let titleName):
                sectionImageName = imageName
                sectionTitleName = titleName
            case .dailyForecasts(let imageName, let titleName):
                sectionImageName = imageName
                sectionTitleName = titleName
            default:
                sectionImageName = ""
                sectionTitleName = ""
            }
            
            if kind == SupplementaryViewKind.header {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherSectionHeaderView.reuseIdentifier, for: indexPath) as! WeatherSectionHeaderView
                headerView.configureHeader(imageName: sectionImageName, titleName: sectionTitleName)
                return headerView
            } else if kind == SupplementaryViewKind.line {
                let lineView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherLineView.reuseIdentifier, for: indexPath) as! WeatherLineView
                return lineView
            } else {
                return nil
            }
        }
        
    }
    
    private func createSnapshot(weatherItem: WeatherItem) {
        
        var snapshot = NSDiffableDataSourceSnapshot<WeatherSectionIdentifier, WeatherItemIdentifier>()
        
        let hourlyForecastsSection = WeatherSectionIdentifier.hourlyForecasts(imageName: "clock", titleName: "Hourly forecast")
        let dailyForecastsSection = WeatherSectionIdentifier.dailyForecasts(imageName: "calendar", titleName: "10 days forecast")
        
        snapshot.appendSections([hourlyForecastsSection, dailyForecastsSection])
        
        let hourlyForecastItems = weatherItem.hourlyForecastItems.map { hourlyForecastItem in
            WeatherItemIdentifier.hourlyForecast(hourlyForecastItem)
        }
        
        let dailyForecastItems = weatherItem.dailyForecastItems.map { dailyForecastItem in
            WeatherItemIdentifier.dailyForecast(dailyForecastItem)
        }
        
        snapshot.appendItems(hourlyForecastItems, toSection: hourlyForecastsSection)
        snapshot.appendItems(dailyForecastItems, toSection: dailyForecastsSection)
        self.viewModel.sections = snapshot.sectionIdentifiers
        
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
