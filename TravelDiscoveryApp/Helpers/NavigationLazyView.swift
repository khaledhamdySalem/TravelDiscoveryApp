//
//  LazyNavigationLinkView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 05/08/2023.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
