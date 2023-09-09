//
//  ResturantPhotesView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 25/08/2023.
//

import SwiftUI
import Kingfisher

struct ResturantPhotesView: View {
    
    let photos: [String]
    @State var mode = "grid"
    @State var shouldShowFullScreenMode: Bool = false
    @State var selectedPhotoIndex = 0
    
    init(photos: [String]) {
        self.photos = photos
        // this changes every UISegmentedControl in your application
        UISegmentedControl.appearance().backgroundColor = .black
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
    var body: some View {
        // For get screen width and height
        GeometryReader { proxy in
            ScrollView {
                
                Picker("Test", selection: $mode) {
                    Text("Grid").tag("grid")
                    Text("List").tag("list")
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowFullScreenMode) {
                        ZStack(alignment: .topLeading) {
                            Color.black.ignoresSafeArea()
                            
                            DestinationHeaderController(imageURLStrings: photos, selectedIndex: selectedPhotoIndex)
                            
                            Button {
                                shouldShowFullScreenMode.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }.opacity(shouldShowFullScreenMode ? 1: 0)
                
                if mode == "grid" {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 3 - 6, maximum: 600), spacing: 2),
                    ], spacing: 4) {
                        ForEach(photos, id: \.self) { photo in
                            Button {
                                selectedPhotoIndex = photos.firstIndex(of: photo) ?? 0
                                shouldShowFullScreenMode.toggle()
                            } label: {
                                KFImage(URL(string: photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width / 3 - 3, height: proxy.size.width / 3)
                                    .clipped()
                            }
                        }
                    }
                } else {
                    ListView(photos: photos)
                }
            }
        }
        .navigationTitle("All Photos").navigationBarTitleDisplayMode(.inline)
    }
}

struct ListView: View {
    
    let photos: [String]
    
    var body: some View {
        ForEach(photos, id: \.self) { photo in
            VStack(alignment: .leading, spacing: 4) {
                KFImage(URL(string: photo))
                    .resizable()
                    .scaledToFill()
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Image(systemName: "message")
                    Image(systemName: "paperplane")
                    Spacer()
                    Image(systemName: "bookmark")
                }
                .padding(.horizontal, 4)
                
                VStack(alignment: .leading) {
                    Text("He woke up. He got up of bed. He went to the restroom and took a shower. the water was cold at first. He made it warm. He took ten minutes to shower. He steeped out of the shower")
                        .padding(.top ,2)
                    Text("Good hob fallen!")
                        .padding(.top, 3)
                    Text("Posted on 10/2/2024")
                        .foregroundColor(Color(.lightGray))
                }
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal, 8)
            }
            .padding(.top, 16)
        }
    }
}

struct ResturantPhotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResturantPhotesView(
                photos:
                    [
                        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/e2f3f5d4-5993-4536-9d8d-b505d7986a5c",
                        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a4d85eff-4c79-4141-a0d6-761cca48eae1",
                        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/20a6783b-3de7-4e58-9e22-bcc6a43b6df6",
                        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0d1d2e79-2f10-4cfd-82da-a1c2ab3638d2",
                        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3923d237-3931-44e5-836f-5de40ec04b31"
                    ]
            )
        }
    }
}
