//
//  TileModifier.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 23/07/2023.
//

import SwiftUI

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: .gray, radius: 3, x: 0.0, y: 2)
    }
}
