//
//  PopularDestinationView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 22/07/2023.
//

import SwiftUI

struct PopularDestinationView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageNames: ["eiffel_tower", "japan", "new_york"], latitude: 48.859565, longitude: 2.353225),
        .init(name: "Tokyo", country: "Japan", imageNames: ["japan"], latitude: 36.2048, longitude: 138.2529),
        .init(name: "New York", country: "US", imageNames: ["new_york"], latitude: 40.7128, longitude: 74.0060)
    ]
        
    var body: some View {
        VStack() {
            HStack() {
                Text("Popular Destination")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink {
                            NavigationLazyView(PopularDetainationDetailsView(destination: destination))
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }
                .padding(.horizontal)
                .navigationTitle("Hello").navigationBarTitleDisplayMode(.inline)
            }
        }
    } 
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0 ) {
            Image(destination.imageNames.first!)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
                .padding(.vertical, 6)
            
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(UIColor(white: 0.5, alpha: 1)))
                .padding(.bottom)
        }
        .padding(.horizontal, 8)
        .asTile()
        .padding(.bottom)
    }
}
struct PopularDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationView()
        DiscoveryView()
    }
}
