//
//  ViewController.swift
//  airQuality
//
//  Created by Silje Marie Flaaten on 31/01/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class DetailsTableController: UITableViewController {
    
    var city: City? {
        didSet {
            _ = city?.calculateHealthRisk()
            DispatchQueue.main.async {
                self.title = "\(self.city?.station ?? "")"
                self.tableView.reloadSections(IndexSet(integer: 0), with: .right)
                self.refresher.endRefreshing()
            }
        }
    }
    
    let refresher = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.register(MeasureView.self, forCellReuseIdentifier: "cellid")
        tableView.tableFooterView = UIView()
        
        tableView.separatorColor = .clear
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.kindaBlack
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refresher
        
        fetchData()
    }
    
    @objc fileprivate func fetchData() {
        let locationService = Location()
        locationService.askPermission { (success) in
            guard success else { return }
            let location = locationService.getCoordinates()
            Network.shared.getDataFor(latitude: location.0 ?? 0, longitude: location.1 ?? 0, km: 20, handler: { (measures) in
                guard let measures = measures else { return }
                self.city = City(measures: measures)
            })
        }
    }
    
}

extension DetailsTableController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city?.measures.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! MeasureView
        cell.measure = city?.measures[indexPath.row]
        cell.isUserInteractionEnabled = false
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
}

