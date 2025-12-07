//
//  SWAPIUser.swift
//  
//
//  Created by CS3714 on 12/7/25.
//

import Foundation

import Foundation

struct SWAPIUser: Identifiable, Codable {
    let id = UUID()
    let name: String
    let birth_year: String
    let height: String          // in cm
    let mass: String            // in kg
    let hair_color: String?
    let skin_color: String?
    let eye_color: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case name
        case birth_year
        case height
        case mass
        case hair_color
        case skin_color
        case eye_color
        case gender
    }
}
