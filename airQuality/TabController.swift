//
//  TabController.swift
//  airQuality
//
//  Created by Adrian Evensen on 03/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = ViewController()
        viewController.tabBarItem.title = "View"
        
        let nearbyController = CitiesTableView()
        nearbyController.title = "Nearby"
        
        viewControllers = [
            viewController,
            nearbyController
        ]
        
    }
    
}
