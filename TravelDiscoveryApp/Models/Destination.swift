//
//  Destination.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 22/07/2023.
//

import Foundation

struct Destination: Hashable, Decodable {
    let name, country: String
    let imageNames: [String]
    let latitude, longitude: Double
}
