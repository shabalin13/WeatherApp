//
//  DailyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by DIMbI4 on 05.11.2023.
//

import UIKit
import Charts

class DailyForecastCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DailyForecastCollectionViewCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var probabilityOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var temperatureMinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var temperatureChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.chartDescription.enabled = false
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.isUserInteractionEnabled = false
        
        return chartView
    }()
    
    private lazy var temperatureMaxLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageStackView.addArrangedSubview(imageView)
        imageStackView.addArrangedSubview(probabilityOfPrecipitationLabel)
        
        temperatureStackView.addArrangedSubview(temperatureMinLabel)
        temperatureStackView.addArrangedSubview(temperatureChartView)
        temperatureStackView.addArrangedSubview(temperatureMaxLabel)
        
        addSubview(lineView)
        addSubview(dateLabel)
        addSubview(imageStackView)
        addSubview(temperatureStackView)
        
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalOffset: CGFloat = 5
        let horizontalOffset: CGFloat = 10
        let spacing: CGFloat = 10
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
            lineView.topAnchor.constraint(equalTo: self.topAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalOffset),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
            
            imageStackView.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: spacing),
            imageStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            imageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            
            temperatureStackView.leadingAnchor.constraint(equalTo: imageStackView.trailingAnchor, constant: spacing),
            temperatureStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalOffset),
            temperatureStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalOffset),
            temperatureStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalOffset),
            temperatureStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            temperatureChartView.heightAnchor.constraint(equalTo: temperatureStackView.heightAnchor, multiplier: 1),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func configureCell(dailyForecastItem: DailyForecastItem) {
        
        if dailyForecastItem.isToday {
            dateLabel.text = "Today"
        } else {
            let date = Date(timeIntervalSince1970: TimeInterval(dailyForecastItem.date))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: dailyForecastItem.timezone)
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        imageView.image = UIImage(named: dailyForecastItem.iconName)
        
        probabilityOfPrecipitationLabel.text = "\(dailyForecastItem.probabilityOfPrecipitation)%"
        
        let minXValue = Double(dailyForecastItem.temperatureTotalMin)
        let maxXValue = Double(dailyForecastItem.temperatureTotalMax)
        
        let dataSet1 = LineChartDataSet(entries: [
            ChartDataEntry(x: minXValue, y: 0.0),
            ChartDataEntry(x: maxXValue, y: 0.0)
        ])
        dataSet1.drawValuesEnabled = false
        dataSet1.drawCirclesEnabled = false
        dataSet1.lineWidth = 6
        dataSet1.lineCapType = .round
        dataSet1.colors = [NSUIColor.secondaryLabel]
        
        let dataSet2 = LineChartDataSet(entries: [
            ChartDataEntry(x: Double(dailyForecastItem.temperatureMin), y: 0.0),
            ChartDataEntry(x: Double(dailyForecastItem.temperatureMax), y: 0.0)
        ])
        dataSet2.drawValuesEnabled = false
        dataSet2.drawCirclesEnabled = false
        dataSet2.lineWidth = 6
        dataSet2.lineCapType = .round
        dataSet2.colors = [NSUIColor.blue]
        
        let data = LineChartData(dataSets: [dataSet1, dataSet2])
        
        temperatureChartView.data = data
        
        temperatureChartView.xAxis.axisMinimum = minXValue - 2
        temperatureChartView.xAxis.axisMaximum = maxXValue + 2
        
        temperatureMinLabel.text = String("\(dailyForecastItem.temperatureMin)°")
        temperatureMaxLabel.text = String("\(dailyForecastItem.temperatureMax)°")
        
    }
}
