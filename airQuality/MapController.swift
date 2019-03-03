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
    
    var stations: [Station]? {
        didSet {
            stations?.forEach({ (station) in
                self.mapView.addAnnotation(MeasureAnnotation(station: station))
            })
        }
    }
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        [
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach { $0.isActive = true }
        mapView.delegate = self
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "id")
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
            let mapCamera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 10000, pitch: 0, heading: 0)
            self.mapView.setCamera(mapCamera, animated: true)
        }
        
        Network.shared.getMapData { (measures) in
            guard let measures = measures else { return }
            var stations = [String : [Measure]]()
            measures.forEach({ (measure) in
                if stations[measure.station ?? ""] == nil {
                    stations[measure.station ?? ""] = [measure]
                } else {
                    stations[measure.station ?? ""]?.append(measure)
                }
            })
            var result = [Station]()
            stations.forEach({ (arg) in
                result.append(Station(measures: arg.value))
            })
            self.stations = result
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "My Location" { return nil }
        guard let a = annotation as? MeasureAnnotation else { return nil }
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "id", for: annotation) as! MKPinAnnotationView
        
        if let healthRisk = a.station.getHealthRisk() {
            switch healthRisk {
            case .low:
                view.pinTintColor = .appleGreen
                break
            case .moderate:
                view.pinTintColor = .appleYellow
                break
            case .high:
                view.pinTintColor = .appleRed
                break
            case .veryHigh:
                view.pinTintColor = .applePurple
                break
            case .unknown:
                view.pinTintColor = .graySuit
            }
        }
        view.canShowCallout = true
        return view
    }
    
}

class MeasureAnnotation: NSObject, MKAnnotation {
    
    var lat: Double
    var long: Double
    var titleText: String
    
    var station: Station
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    lazy var title: String? = NSLocalizedString(self.titleText, comment: "Målepunk annotation")
    
    var subtitle: String? = ""
    
    init(station: Station) {
        self.station = station
        
        self.lat = station.latitude ?? 0
        self.long = station.longitude ?? 0
        
        self.titleText = station.name ?? ""
        self.subtitle = station.area ?? ""
        
    }
    
}
