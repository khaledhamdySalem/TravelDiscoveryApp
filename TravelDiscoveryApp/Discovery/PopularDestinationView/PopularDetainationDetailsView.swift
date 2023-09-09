//
//  PopularDetainationDetailsView.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 05/08/2023.
//

import SwiftUI
import MapKit


struct DestinationDetails: Decodable {
    let description: String
    let photos: [String]
}

class PopularDetainationDetailsViewViewModel: ObservableObject {
   
    @Published var isLoading = true
    @Published var destinationDetails: DestinationDetails?
    
    init(name: String) {
        guard let name = name.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, eror in
           
            DispatchQueue.main.async {
                do {
                    let destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data!)
                    self.destinationDetails = destinationDetails
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

struct PopularDetainationDetailsView: View {
    
    let destination: Destination
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true
    
    @ObservedObject var vm: PopularDetainationDetailsViewViewModel
    
    init(destination: Destination) {
        self.destination = destination
        self.vm = .init(name: destination.name)
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    
    var body: some View {
        ScrollView {
            if let images = vm.destinationDetails?.photos {
                DestinationHeaderController(imageURLStrings: images, selectedIndex: 5)
                    .frame(height: 300)
            }
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)
                
                Text(vm.destinationDetails?.description ?? "")
                    .padding(.top, 4)
                    .font(.system(size: 14))
                
                HStack{ Spacer() }
            }
            .padding(.horizontal)
            
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                
                Button(action: { isShowingAttractions.toggle() }, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                })
                
                // UIKit : UISwitch
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
                
            }.padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }
            .frame(height: 300)
            
        }.navigationBarTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees", imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)
    ]
}

struct CustomMapAnnotation: View {
    
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.8)))
                )
            Text(attraction.name)
                .font(.system(size: 13, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .background(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
            
                .foregroundColor(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.8)))
                )
        }
        .shadow(radius: 5)
    }
}

struct PopularDetainationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDetainationDetailsView(destination: .init(name: "paris", country: "France", imageNames: [""], latitude: 48.859565, longitude: 2.353225))
    }
}
