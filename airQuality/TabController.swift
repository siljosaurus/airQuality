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
        
        let viewController = UINavigationController(rootViewController: DetailsTableController())
        viewController.tabBarItem.title = "Detaljer"
        viewController.tabBarItem.image = UIImage(named: "my_location")
        
        let nearbyController = OverviewController()
        nearbyController.title = "Oversikt"
        
        let mapController = MapController()
        mapController.title = "Map"
        mapController.tabBarItem.image = UIImage(named: "map")
        
        tabBar.tintColor = .kindaBlack
        
        viewControllers = [
            mapController,
            viewController,
            nearbyController,
        ]
        
    }
    
}
