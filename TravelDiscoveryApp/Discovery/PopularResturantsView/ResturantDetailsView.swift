//
//  ResturantDetailsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 15/08/2023.
//

import SwiftUI
import Kingfisher

struct ResturantDetails: Codable {
    let name, city, country, category, description: String
    let popularDishes: [PopularDishes]
    let photos: [String]
    let reviews: [Review]
}

struct PopularDishes: Codable, Hashable {
    let name: String
    let price: String
    let numPhotos: Int
    let photo: String
}

struct Review: Codable, Hashable {
    let user: ReviewUser
    let rating: Int
    let text: String
}

struct ReviewUser: Codable, Hashable {
    let id: Int
    let username: String
    let firstName: String
    let lastName: String
    let profileImage: String
    let followers: Int
    let following: Int
    let posts: [Post]
}

struct Post: Codable, Hashable {
    let title: String
    let imageUrl: String
    let views: String
}

class ResturantDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var details: ResturantDetails?
    init() {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                let details = try? JSONDecoder().decode(ResturantDetails.self, from: data)
                self.details = details
            }
        }.resume()
    }
}

struct ResturantDetailsView: View {
    
    let resturant: Restaurant
    
    @ObservedObject var vm = ResturantDetailsViewModel()
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading ) {
                Image(resturant.imageName)
                    .resizable()
                    .scaledToFill()
                LinearGradient(colors: [Color.clear, Color.black], startPoint: .center, endPoint: .bottom)
                HStack() {
                    VStack(alignment: .leading) {
                        Text(resturant.name)
                        HStack {
                            ForEach(0..<5, id: \.self) { num in
                                Image(systemName: "star.fill")
                            }
                            .foregroundColor(.orange)
                            .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    Spacer()
                    NavigationLink {
                        ResturantPhotesView(photos: vm.details?.photos ?? [])
                    } label: {
                        Text("See more Photos")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white)
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(vm.details?.name ?? "")
                    .font(.system(size: 16, weight: .bold))
                
                Text(vm.details?.country ?? "")
                    .font(.system(size: 14, weight: .regular))
                
                HStack {
                    ForEach(0..<3, id: \.self) { num in
                        Image(systemName: "dollarsign.circle.fill")
                    }.foregroundColor(.orange)
                }
                Text(vm.details?.description ?? "")
                    .font(.system(size: 14, weight: .regular))
                
            }.padding()
            
            HStack {
                Text("Popular Dishes")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        DishCell(dish: dish)
                    }
                }
                .padding()
            }
            CustomerList(reviews: vm.details?.reviews ?? [])
        }
        .navigationTitle("Resturant Details").navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomerList: View {
    
    let reviews: [Review]
    
    var body: some View {
        HStack {
            Text("Customer Revies")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }.padding(.horizontal)
        
        // 😅😅😅😅 Rating 😅😅😅😅
        ForEach(reviews, id: \.self) { review in
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    HStack() {
                        KFImage(URL(string: review.user.profileImage))
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(16)
                        
                        VStack(alignment: .leading,spacing: 0) {
                            Text(review.user.firstName + " " + review.user.lastName)
                            ZStack {
                                HStack(spacing: 0) {
                                    ForEach(0..<5, id: \.self) { num in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(Color(.gray))
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 0) {
                                    ForEach(0..<review.rating, id: \.self) { num in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.orange)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    Spacer()
                    Text("Des 2020")
                }
                Text(review.text)
                    .multilineTextAlignment(.leading)
                
            }
            .padding(.top, 8)
            .padding(.horizontal)
        }
    }
}

struct DishCell: View {
    
    let dish: PopularDishes
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: dish.photo))
                    .resizable()
                    .scaledToFill()
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                    .shadow(radius: 5)
                    .padding(.vertical, 2)
                LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                Text(dish.price)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                    .padding(.leading, 4)
            }
            
            .frame(height: 120)
            .cornerRadius(5)
            
            Text(dish.name)
                .font(.system(size: 14, weight: .bold))
            Text("\(dish.numPhotos) Photos")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
        }
    }
}


struct ResturantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResturantDetailsView(resturant: .init(name: "Japan's Fitness Tapes", imageName: "tapas"))
        DiscoveryView()
    }
}
