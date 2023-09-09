//
//  UserDetailsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 01/09/2023.
//

import SwiftUI

struct UserDetailsView: View {
    
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .cornerRadius(.infinity)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                //
                Text(user.name)
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    Text("@AymanDamas20 •")
                        .font(.system(size: 12, weight: .semibold))
                    
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10, weight: .semibold))
                    Text("2541")
                        .font(.system(size: 12, weight: .regular))
                }
                
                Text("Youtube, Vlogger, Travel Creator")
                    .foregroundColor(Color(.lightGray))
                    .font(.system(size: 14, weight: .semibold))
                
                HStack(spacing: 12) {
                    VStack {
                        Text("60.000")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Follwers")
                            .font(.system(size: 9, weight: .regular))
                    }
                    
                    Spacer()
                        .frame(width: 0.5, height: 12)
                        .background(Color(.lightGray))
                    
                    VStack {
                        Text("2,122")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                
                HStack(spacing: 12) {
                    Button {
                        // Action
                    } label: {
                        HStack {
                            Spacer()
                            Text("Follow")
                                .foregroundColor(Color.white)
                                .padding()
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color(.orange))
                        .cornerRadius(100)
                    }
                    
                    Button {
                        // Action
                    } label: {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .foregroundColor(Color.black)
                                .padding()
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(100)
                    }
                }
                .font(.system(size: 16, weight: .semibold))
                
                ForEach(0..<3, id: \.self) { num in
                    VStack(alignment: .leading) {
                        Image("japan")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        VStack(alignment: .leading) {
                            HStack {
                                Image("amy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 34)
                                    .cornerRadius(.infinity)
                                VStack(alignment: .leading) {
                                    Text("Test post text here for preview to see what's going")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("5000k views ")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }.padding(.horizontal, 8)
                            
                            HStack {
                                ForEach(0..<3, id: \.self) { num in
                                   Text("#Traveling")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(.blue)
                                        .cornerRadius(20)
                                }
                            }.padding(.bottom)
                        }
                    }
                    .cornerRadius(12)
                    .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
                    
                    
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Username")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: .init(name: "Amy", imageName: "amy"))
    }
}
