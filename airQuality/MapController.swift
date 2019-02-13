//
//  MapController.swift
//  airQuality
//
//  Created by Adrian Evensen on 12/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        [
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach { $0.isActive = true }
        mapView.delegate = self
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "id")
        mapView.userTrackingMode = .followWithHeading
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.showsPointsOfInterest = false
        
        let locationService = Location()
        locationService.askPermission { (success) in
            guard success else { return }
            let location = locationService.getCoordinates()
            let coordinate = CLLocationCoordinate2D(latitude: location.0 ?? 0, longitude: location.1 ?? 0)
            
            let mapCamera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 5000, pitch: 0, heading: 0)
            mapView.setCamera(mapCamera, animated: true)
                       
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "My Location" { return nil }

        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "id", for: annotation)
        view.image = UIImage(named: "near_me")

        view.canShowCallout = true

        return view
    }
    
}

class MeasureAnnotation: NSObject, MKAnnotation {
    
    var lat: Double
    var long: Double
    var titleText: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    lazy var title: String? = NSLocalizedString(self.titleText, comment: "Målepunk annotation")
    
    var subtitle: String? = "Hei"
    
    init(title: String, latitude: Double, longitude: Double) {
        self.lat = latitude
        self.long = longitude
        self.titleText = title
    }
    
    
}
