//
//  Attraction.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 07/08/2023.
//

import UIKit

struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let latitude, longitude: Double
}
