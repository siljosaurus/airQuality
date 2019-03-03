//
//  Helserisiko.swift
//  airQuality
//
//  Created by Silje Marie Flaaten on 03/03/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class Helserisiko: UIViewController {
    
    let helloLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Takk til luftkvalitet.info og nilu.no som samler inn og gjør tilgjengelig målinger om luftkvalitet og dens helserisiko i hele Norge."
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        thanksLabel()
    }
    
    
    func thanksLabel() {
        view.addSubview(helloLabel)
        helloLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        helloLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
    }
    
}



