//
//  UIView+Extension.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 23/07/2023.
//

import SwiftUI

extension View {
    func asTile() -> some View {
        return modifier(TileModifier())
    }
}
