//
//  TrendingCreatorsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 22/07/2023.
//

import SwiftUI

struct TrendingCreatorsView: View {
    
    let users: [User] = [
        .init(name: "Amy Adams", imageName: "amy"),
        .init(name: "Billy Childs ", imageName: "billy"),
        .init(name: "Sam Smith", imageName: "sam")
    ]
    
    var body: some View {
        VStack() {
            HStack() {
                Text("Trending Categories")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(users, id: \.self) { user in
                        NavigationLink {
                            UserDetailsView(user: user)
                        } label: {
                            DiscoveryUserView(user: user)
                            .padding(.bottom)
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
struct DiscoveryUserView: View {
    
    let user: User
    
    var body: some View {
        VStack(spacing: 4) {
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(.infinity)
            Text(user.name)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
        }
        .frame(width: 60)
        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
        .foregroundColor(.black)
    }
}

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
        TrendingCreatorsView()
    }
}


