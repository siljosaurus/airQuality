//
//  CitiesTableView.swift
//  airQuality
//
//  Created by Silje Marie Flaaten on 02/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import UIKit

class CitiesTableView: UITableViewController {
    
    var cities: [City]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    let refresher = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        title = "Nearby"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchData()
        
        tableView.tableFooterView = UIView()
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refresher
        
    }
    
    @objc fileprivate func fetchData() {
        refresher.beginRefreshing()
        let locationService = Location()
        locationService.askPermission { (success) in
            guard success else { return }
            let location = locationService.getCoordinates()
            Network.shared.getDataFor(latitude: location.0 ?? 0, longitude: location.1 ?? 0, km: 2, handler: { (measures) in
                self.cities = measures
            })
        }
    }
    
}

extension CitiesTableView {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let city = cities?[indexPath.row]
        //cell.textLabel?.text = "\(city?.station ?? "") \(city?.component ?? "") - \(city?.value ?? -1)\(city?.unit ?? "")"
        
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(string: "\(city?.station ?? "") : ", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
            ]))
        
        attributedString.append(NSAttributedString(string: "\(city?.value ?? -1)", attributes: [
            NSAttributedString.Key.foregroundColor : city?.color?.hexStringToUIColor() as Any
            ]))
        
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
}
