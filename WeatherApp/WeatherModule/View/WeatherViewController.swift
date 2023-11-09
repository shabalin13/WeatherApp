//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by DIMbI4 on 01.11.2023.
//

import UIKit
import RxSwift

class WeatherViewController: UIViewController {
    
    private var viewModel: WeatherViewModelProtocol
    
    private lazy var collectionView = createCollectionView()
    private lazy var dataSource = createDataSource()
    
    private let disposeBag = DisposeBag()
    
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
        
        setupView()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getWeather()
    }
    
    // MARK: Functions to set up view
    private func setupView() {
        self.navigationItem.title = "Weather"
        self.view.backgroundColor = .systemBackground
        
        setupToolBar()
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
    
    // MARK: RxSwift subsription
    private func subscribe() {
        viewModel.weatherItem.subscribe(onNext: { weatherItem in
            self.createSnapshot(weatherItem: weatherItem)
        })
        .disposed(by: disposeBag)
        
    }
    
    // MARK: CollectionView functions
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(WeatherSectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: WeatherSectionHeaderView.reuseIdentifier)
        collectionView.register(WeatherLineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.line, withReuseIdentifier: WeatherLineView.reuseIdentifier)
        
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.reuseIdentifier)
        collectionView.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: DailyForecastCollectionViewCell.reuseIdentifier)
        collectionView.register(WindCollectionViewCell.self, forCellWithReuseIdentifier: WindCollectionViewCell.reuseIdentifier)
        collectionView.register(SquareCollectionViewCell.self, forCellWithReuseIdentifier: SquareCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewHorizontalOffset: CGFloat = 15
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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionIdentifier = self.viewModel.sections[sectionIndex]
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
//            headerItem.pinToVisibleBounds = true
            
            let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
            let lineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(lineItemHeight))
            let lineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.line, alignment: .top)
            lineItem.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            switch sectionIdentifier {
            case .main:
                return nil
            case .hourlyForecasts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 5)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.boundarySupplementaryItems = [headerItem, lineItem]
                
                let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewKind.background)
                section.decorationItems = [sectionBackground]
                
                return section
            case .dailyForecasts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 5, bottom: 20, trailing: 5)
                section.boundarySupplementaryItems = [headerItem, lineItem]
                
                let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewKind.background)
                section.decorationItems = [sectionBackground]
                return section
            case .wind:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 5, bottom: 10, trailing: 5)
                section.boundarySupplementaryItems = [headerItem]
                
                let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewKind.background)
                section.decorationItems = [sectionBackground]
                return section
            case .squares:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                
                return section
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        layout.register(WeatherSectionBackgroundView.self, forDecorationViewOfKind: DecorationViewKind.background)
        
        return layout
    }
    

    private func createDataSource() -> UICollectionViewDiffableDataSource<WeatherSectionIdentifier, WeatherItemIdentifier> {
        
        let dataSource = UICollectionViewDiffableDataSource<WeatherSectionIdentifier, WeatherItemIdentifier>.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
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
            case .wind:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindCollectionViewCell.reuseIdentifier, for: indexPath) as! WindCollectionViewCell
                cell.configureCell(windItem: itemIdentifier.wind!)
                return cell
            case .squares:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.reuseIdentifier, for: indexPath) as! SquareCollectionViewCell
                switch itemIdentifier.squares! {
                case .feelsTemperature(let feelsTemperatureItem):
                    cell.configureCell(feelsTemperatureItem: feelsTemperatureItem)
                case .visibility(let visibilityItem):
                    cell.configureCell(visibilityItem: visibilityItem)
                case .sun(let sunItem):
                    cell.configureCell(sunItem: sunItem)
                case .humidity(let humidityItem):
                    cell.configureCell(humidityItem: humidityItem)
                case .pressure(let pressureItem):
                    cell.configureCell(pressureItem: pressureItem)
                case .precipitation(let precipitationItem):
                    cell.configureCell(precipitationItem: precipitationItem)
                }
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
            case .main:
                return nil
            case .hourlyForecasts(let imageName, let titleName):
                sectionImageName = imageName
                sectionTitleName = titleName
            case .dailyForecasts(let imageName, let titleName):
                sectionImageName = imageName
                sectionTitleName = titleName
            case .wind(let imageName, let titleName):
                sectionImageName = imageName
                sectionTitleName = titleName
            case .squares:
                return nil
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
        return dataSource
    }
    
    private func createSnapshot(weatherItem: WeatherItem) {
        
        var snapshot = NSDiffableDataSourceSnapshot<WeatherSectionIdentifier, WeatherItemIdentifier>()
        
        let hourlyForecastsSection = WeatherSectionIdentifier.hourlyForecasts(imageName: "clock", titleName: "Hourly forecast")
        let dailyForecastsSection = WeatherSectionIdentifier.dailyForecasts(imageName: "calendar", titleName: "10-day forecast")
        let windSection = WeatherSectionIdentifier.wind(imageName: "wind", titleName: "Wind")
        let squaresSection = WeatherSectionIdentifier.squares
        
        snapshot.appendSections([hourlyForecastsSection, dailyForecastsSection, windSection, squaresSection])
        
        let hourlyForecastItems = weatherItem.hourlyForecastItems.map { hourlyForecastItem in
            WeatherItemIdentifier.hourlyForecast(hourlyForecastItem)
        }
        
        let dailyForecastItems = weatherItem.dailyForecastItems.map { dailyForecastItem in
            WeatherItemIdentifier.dailyForecast(dailyForecastItem)
        }
        
        snapshot.appendItems(hourlyForecastItems, toSection: hourlyForecastsSection)
        snapshot.appendItems(dailyForecastItems, toSection: dailyForecastsSection)
        snapshot.appendItems([WeatherItemIdentifier.wind(weatherItem.windItem)], toSection: windSection)
        
        let squaresItems = [WeatherItemIdentifier.squares(.feelsTemperature(weatherItem.feelsTemperatureItem)),
                            WeatherItemIdentifier.squares(.visibility(weatherItem.visibilityItem)),
                            WeatherItemIdentifier.squares(.sun(weatherItem.sunItem)),
                            WeatherItemIdentifier.squares(.humidity(weatherItem.humidityItem)),
                            WeatherItemIdentifier.squares(.pressure(weatherItem.pressureItem)),
                            WeatherItemIdentifier.squares(.precipitation(weatherItem.precipitationItem))]
        
        snapshot.appendItems(squaresItems, toSection: squaresSection)
        self.viewModel.sections = snapshot.sectionIdentifiers
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: objc action functions
    @objc func goToCities() {
        self.viewModel.goToCities()
    }
    
//     MARK: deinit
    deinit {
        print("WeatherViewController deinit")
    }

}
