//
//  Network.swift
//  airQuality
//
//  Created by Adrian Evensen on 31/01/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation


class Network {
    // Singelton
    static let shared = Network()
}


extension Network {
    
    func getMapData(handler: @escaping ([Measure]?) -> ()) {
        guard let url = URL(string: "https://api.nilu.no/obs/utd?") else {
            handler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                handler(nil)
                print("failed to get data: ", err)
                return
            }
            guard let data = data else {
                handler(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Measure].self, from: data)
                handler(decodedData)
            } catch let err {
                print("failed to decode", err)
                handler(nil)
            }
        }.resume()
    }
    
    func getDataFor(latitude: Double, longitude: Double, km: Int, handler: @escaping ([Measure]?) -> ()) {
        //guard let url = URL(string: "https://api.nilu.no/aq/utd/59.913868/10.752245/20") else {
        guard let url = URL(string: "http://api.nilu.no/aq/utd/\(latitude)/\(longitude)/\(km)") else {
            handler(nil)
            print("Failed to make URL from input")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                handler(nil)
                print("Failed URLSession: ", err)
                return
            }
            
            guard let data = data else {
                handler(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Measure].self, from: data)
                handler(decodedData)
            } catch let err {
                print("Failed to decode data: ", err)
                handler(nil)
            }
        }.resume()
    }
}
