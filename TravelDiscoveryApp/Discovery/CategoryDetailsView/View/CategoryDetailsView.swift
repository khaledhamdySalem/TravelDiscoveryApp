//
//  CategoryDetailsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 29/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryDetailsView: View {
    
    @ObservedObject var vm: CategoryDetailsViewViewModel
    
    let name: String
    
    init(name: String) {
        print("Khaled200- Loading CategoryDeatils \(name)")
        print("Khaled200- Loading CategoryDeatils \(name)")
        self.name = name
        self.vm = CategoryDetailsViewViewModel(name: name)
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading...")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.all)
                .background(.gray)
                .cornerRadius(8)
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty  {
                        VStack {
                            Image(systemName: "xmark.octagon.fill")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.red)
                            Text(vm.errorMessage)
                        }
                    } else {
                        ScrollView {
                            ForEach(vm.places, id: \.self) { place in
                                VStack(alignment: .leading, spacing: 0) {
                                    WebImage(url: URL(string: place.thumbnail))
                                        .resizable()
                                        .indicator(.activity)
                                        .transition(.fade(duration: 0.5))
                                        .scaledToFill()
                                    Text(place.name)
                                        .font(.system(size: 12, weight: .semibold))
                                        .padding()
                                }
                                .asTile()
                                .padding(.all)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(name.capitalized )
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(name: "art")
    }
}
