//
//  UserManager.swift
//  
//
//  Created by CS3714 on 12/7/25.
//

import Foundation
import Combine

class UserManager: ObservableObject {
    
    @Published var profile: SWAPIUser?       // Currently logged-in user's profile
    @Published var isLoadingProfile = false  // Track loading state for UI feedback
    
    func fetchUser(_ id: Int) {
        guard let url = URL(string: "https://swapi.dev/api/people/\(id)/") else { return }
        isLoadingProfile = true
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoadingProfile = false } }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(SWAPIUser.self, from: data)
                DispatchQueue.main.async {
                    self.profile = user
                    print("Fetched profile: \(user.name) - \(user.birth_year)")
                }
            } catch {
                print("Error decoding user \(id):", error)
            }
        }.resume()
    }
}
