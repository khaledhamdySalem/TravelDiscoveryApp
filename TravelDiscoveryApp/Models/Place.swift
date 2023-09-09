//
//  Plac.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 29/07/2023.
//

import Foundation

struct Place: Decodable, Hashable {
    let id: Int
    let name: String
    let country: String
    let description: String?
    let thumbnail: String
    let photos: [String]?
}
