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
            
            /*
            Network.shared.getDataFor(latitude: location.0 ?? 0, longitude: location.1 ?? 0, km: 10, handler: { (cities) in
                cities?.forEach({ (city) in
                    print("color: ", city.color)
                    
                    DispatchQueue.main.async {
                        self.view.backgroundColor = self.hexStringToUIColor(hex: "#\(city.color ?? "")")
                    }
                    
                })
            })
            */

            
            Network.shared.getDataFor(latitude: location.0 ?? 0, longitude: location.1 ?? 0, km: 5, handler: { (measures) in
                print("We got \(measures?.count ?? -1) results")
                measures?.forEach({ (measure) in
                    print("\(measure.component ?? ""): ", measure.value ?? 0, " \(measure.unit ?? "")")
                })
            })


        }
    }

    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

