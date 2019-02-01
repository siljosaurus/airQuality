//
//  ViewController.swift
//  airQuality
//
//  Created by Silje Marie Flaaten on 31/01/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let locationService = Location()
        locationService.askPermission { (success) in
            guard success else { return }
            let location = locationService.getCoordinates()
            print("Lat: \(location.0 ?? 0), Long: \(location.1 ?? 0)")
        }
    }


}

