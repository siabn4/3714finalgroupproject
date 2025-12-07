//
//  UserManager.swift
//  
//
//  Created by CS3714 on 12/7/25.
//

import Foundation
import Combine

class UserManager: ObservableObject {
    @Published var groupOne: [SWAPIUser] = []
    @Published var groupTwo: [SWAPIUser] = []
    @Published var allUsers: [SWAPIUser] = []
    
    // Your 8 specific character IDs
    private let groupOneIDs = [36, 22, 13, 78]
    private let groupTwoIDs = [45, 62, 83, 12]
    
    func fetchUsers() {
        let allIDs = groupOneIDs + groupTwoIDs
        
        for id in allIDs {
            fetchUserByID(id)
        }
    }
    
    private func fetchUserByID(_ id: Int) {
        guard let url = URL(string: "https://swapi.dev/api/people/\(id)/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(SWAPIUser.self, from: data)
                
                DispatchQueue.main.async {
                    self.allUsers.append(user)
                    
                    if self.groupOneIDs.contains(id) {
                        self.groupOne.append(user)
                    } else if self.groupTwoIDs.contains(id) {
                        self.groupTwo.append(user)
                    }
                }
            } catch {
                print("Failed to load user \(id):", error)
            }
        }.resume()
    }
}
