//
//  ContentView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 20/07/2023.
//

import SwiftUI

struct DiscoveryView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                Color.diccoverBackground
                    .offset(y: 400)
                
                createViews()
            }
        }
    }
    
    private func createViews() -> some View {
        return ScrollView() {
            VStack (spacing: 32){
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                    Text("Where do you want to go")
                        .font(.system(size: 14, weight: .bold))
                    Spacer()
                    
                }
                .padding(.horizontal, 8)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                .background(Color(UIColor(white: 0.90, alpha: 0.8)))
                .cornerRadius(16)
                // Discovery CategoriesView
                DiscoveryCategoriesView()
            }
            
            VStack {
                // Popular DestinationView()
                PopularDestinationView()
              
                // Popular ResturantsView()
                PopularResturantsView()
              
                // Trending CreatorsView()
                TrendingCreatorsView()
            }
            .background(Color.diccoverBackground)
            .cornerRadius(20)
            .padding(.top, 32)
        }
        .navigationTitle("Discovery")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}


extension UIImage {
    static let magnifyingglass = Image(systemName: "magnifyingglass")
}
