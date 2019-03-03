//
//  MeasureView.swift
//  airQuality
//
//  Created by Adrian Evensen on 03/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class MeasureView: UITableViewCell {
    
    var measure: Measure! {
        didSet {
            setupLayout()
            setupUI()
            setupDescription()
        }
    }
    
    let colorIndex: UIView = {
        let colorIndex = UIView()
        colorIndex.translatesAutoresizingMaskIntoConstraints = false
        
        return colorIndex
    }()

    let componentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    fileprivate func setupLayout() {
        addSubview(colorIndex)
        [
            colorIndex.leftAnchor.constraint(equalTo: leftAnchor),
            colorIndex.widthAnchor.constraint(equalToConstant: 7),
            colorIndex.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            colorIndex.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
            ].forEach { $0.isActive = true }
        
        addSubview(componentLabel)
        [
            componentLabel.leftAnchor.constraint(equalTo: colorIndex.rightAnchor, constant: 10),
            componentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            componentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
            ].forEach { $0.isActive = true }
        
        addSubview(descriptionLabel)
        [
            descriptionLabel.leftAnchor.constraint(equalTo: componentLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: componentLabel.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: componentLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
            ].forEach { $0.isActive = true }
    }
    
    fileprivate func setupUI() {
        let healthRisk = measure.calculateHealthRisk()
        
        var description = ""
        
        switch healthRisk {
        case .low:
            colorIndex.backgroundColor = .appleGreen
            description = "Lite 😸"
            break
        case .moderate:
            colorIndex.backgroundColor = .appleYellow
            description = "Moderat 😔"
            break
        case .high:
            colorIndex.backgroundColor = .appleRed
            description = "Høyt ☹️"
            break
        case .veryHigh:
            colorIndex.backgroundColor = .applePurple
            description = "Veldig høyt 🤮"
            break
        case .unknown:
            colorIndex.backgroundColor = .graySuit
            description = "Ingen data\n"
        }
        
        if healthRisk != .unknown {
            description += " -  \(Int(measure.value ?? -1 )) \(measure.unit ?? "")\n"
        }
        
        descriptionLabel.text = description// + " -  \(Int(measure.value ?? -1 )) \(measure.unit ?? "")\n"
        
        var text = ""
        
        switch measure.component {
        case "PM2.5", "PM10":
            text = "Svevestøv"
            break
        case "O3":
            text += "Bakkenær Ozon - O3"
            break
        case "NO2":
            text = "Nitrogendioksid - NO2"
            break
        case "SO2":
            text = "Svoveldioksid - SO2"
        default:
            break
        }
        
        
        let attrText = NSMutableAttributedString()
        attrText.append(NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : UIColor.kindaBlack
            ]))
        attrText.append(NSAttributedString(string:" - \(measure.component ?? "")", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : UIColor.graySuit
            ]))
        componentLabel.attributedText = attrText
    }

    fileprivate func setupDescription() {

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
