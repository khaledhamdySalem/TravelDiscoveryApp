//
//  ActivityIndicatoy.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 29/07/2023.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
   
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let ac = UIActivityIndicatorView()
        ac.style = .large
        ac.color = .white
        ac.startAnimating()
        return ac
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    typealias UIViewType = UIActivityIndicatorView

}

