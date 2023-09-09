//
//  PopularResturantsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 22/07/2023.
//

import SwiftUI

struct PopularResturantsView: View {
    
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", imageName: "tapas"),
        .init(name: "Bar & Grill", imageName: "bar_grill"),
    ]
    
    var body: some View {
        VStack() {
            HStack() {
                Text("Popular places to eat")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(restaurants, id: \.self) { resturant in
                        NavigationLink {
                            ResturantDetailsView(resturant: resturant)
                        } label: {
                            ResturantTile(resturant: resturant)
                                .padding(.bottom)
                                .foregroundColor(Color(.label))
                        }
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top, 4)
            }
        }
    }
}

struct ResturantTile: View {
    
    let resturant: Restaurant
    
    var body: some View {
        HStack(spacing: 8) {
            Image(resturant.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(4)
                .padding(.leading, 8)
                .padding(.vertical, 6)
            VStack(alignment: .leading, spacing: 6) {
                HStack() {
                    Text(resturant.name)
                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        // TODO: - Action
                    } label: {
                        Image(systemName: "ellipsis").foregroundColor(Color.gray)
                    }
                }
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text("4.3 . shunims . $$")
                }
                Text("Tokyo, Japan")
            }
            .font(.system(size: 12, weight: .semibold))
            Spacer()
        }
        .frame(width: 240)
        .asTile()
        
    }
}

struct PopularResturantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularResturantsView()
        DiscoveryView()
    }
}
