//
//  WeatherTableViewCell.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 13/09/24.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    struct ConstraintContants {
        static let leading: CGFloat = 16
        static let trailing: CGFloat = 16
        static let top: CGFloat = 12
        static let bottom: CGFloat = 12
    }
    
    lazy var cityNameLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
       return titleLabel
    }()
    
    lazy var minTempLabel: UILabel = {
       let minTempLabel = UILabel()
        minTempLabel.font = UIFont(name: "System", size: 10)
       return minTempLabel
    }()
    
    lazy var maxTempLabel: UILabel = {
       let maxTempLabel = UILabel()
        maxTempLabel.font = UIFont(name: "System", size: 10)
       return maxTempLabel
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(cityNameLabel)
        self.addSubview(minTempLabel)
        self.addSubview(maxTempLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstraintContants.leading),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ConstraintContants.trailing),
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstraintContants.top)
        ])
        
        NSLayoutConstraint.activate([
            minTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstraintContants.leading),
            minTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ConstraintContants.trailing),
            minTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: ConstraintContants.top)
        ])
        
        NSLayoutConstraint.activate([
            maxTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstraintContants.leading),
            maxTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ConstraintContants.trailing),
            maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: ConstraintContants.top),
            maxTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ConstraintContants.bottom)
        ])
    }
    
    // Here I'm not passing WeatherModel in the arguments, I'm passing WeatherModelRepresentable because this cell can be resused with any model which confirms to WeatherModelRepresentable protocol. 
    func configureCell(weatherModelRepresentable: WeatherModelRepresentable) {
        cityNameLabel.text = weatherModelRepresentable.city
        minTempLabel.text = "\(LocalisedText.minTemp.localised): " + String(weatherModelRepresentable.tempMin)
        maxTempLabel.text = "\(LocalisedText.maxTemp.localised): " + String(weatherModelRepresentable.tempMax)
    }
}
