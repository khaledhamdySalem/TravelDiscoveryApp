//
//  DiscoveryCategoriesView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 22/07/2023.
//

import SwiftUI

struct DiscoveryCategoriesView: View {
    
    var categories: [Category] = [Category(name: "Art", imageName: "paintpalette.fill"),
                                  Category(name: "Sports", imageName: "sportscourt.fill"),
                                  Category(name: "Live Events", imageName: "music.mic"),
                                  Category(name: "Food", imageName: "music.mic"),
                                  Category(name: "History", imageName: "music.mic")]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        NavigationLazyView(CategoryDetailsView(name: category.name))
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: category.imageName)
                                .font(.system(size: 20))
                                .foregroundColor(.orange)
                                .frame(width: 64, height: 64)
                                .background(.white)
                                .cornerRadius(64)
                                .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                            Text(category.name)
                                .font(.system(size: 12, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 68)
                    }
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

struct DiscoveryCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
            CategoryDetailsView(name: "art")
            DiscoveryView()
    }
}
