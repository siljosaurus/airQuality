//
//  CitiesTableView.swift
//  airQuality
//
//  Created by Silje Marie Flaaten on 02/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class OverviewController: UIViewController {
    
    var city: City? {
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }

    let locationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()

        fetchData()
    }
    
    fileprivate func setupLayout() {
        view.addSubview(locationTitle)
        [
            locationTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            locationTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            locationTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            ].forEach { $0.isActive = true }
    }
    
    fileprivate func setupUI() {
        locationTitle.text = "hello"
    }
    
    @objc fileprivate func fetchData() {
        let locationService = Location()
        locationService.askPermission { (success) in
            guard success else { return }
            let location = locationService.getCoordinates()
            Network.shared.getDataFor(latitude: location.0 ?? 0, longitude: location.1 ?? 0, km: 2, handler: { (measures) in
                guard let measures = measures else { return }
                self.city = City(measures: measures)
            })
        }
    }
    
}
