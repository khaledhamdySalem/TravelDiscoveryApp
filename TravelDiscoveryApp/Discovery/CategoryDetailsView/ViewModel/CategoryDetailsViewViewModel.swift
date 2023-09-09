//
//  CategoryDetailsViewViewModel.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 29/07/2023.
//

import Foundation

class CategoryDetailsViewViewModel: ObservableObject {
   
    @Published var isLoading = true
    @Published var places: [Place] = [Place]()
    @Published var errorMessage: String = ""
    
    // TODO: -  Perfome Network Code Here
    init(name: String) {
        
        let urlSring = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())"
     
        guard let url = URL(string: urlSring) else {
            isLoading = false
            errorMessage = "The URL Is Wronge"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else { return }
            
            if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Bad status: 400"
                }
                return
            }
            
            self.isLoading = false
            do {
                let places = try JSONDecoder().decode([Place].self, from: data)
                self.places = places
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
}

