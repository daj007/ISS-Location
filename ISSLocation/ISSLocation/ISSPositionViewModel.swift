//
//  ISSPositionViewModel.swift
//  ISSLocation
//
//  Created by David Amezcua on 5/16/24.
//

import Foundation

class ISSPositionViewModel: ObservableObject {
    @Published var position: String = "Loading..."
    @Published var animateImage = false

    func fetchISSPosition() {
        animateImage = true
        
        guard let url = URL(string: "http://api.open-notify.org/iss-now.json") else {
            position = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.position = "Error: Failed to fetch data: \(error)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.position = "No data received"
                }
                return
            }
            
            self.updateISSPosition(with: data)
        }.resume()
    }
    
    func updateISSPosition(with jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            let issData = try decoder.decode(ISSPositionResponse.self, from: jsonData)
            DispatchQueue.main.async {
                self.position = "Latitude: \(issData.issPosition.latitude), Longitude \(issData.issPosition.longitude)"
            }
        } catch {
            DispatchQueue.main.async {
                self.position = "Error decoding: \(error.localizedDescription)"
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animateImage = false
        }
    }
}

