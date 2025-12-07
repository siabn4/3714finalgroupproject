//
//  SWAPIUser.swift
//  
//
//  Created by CS3714 on 12/7/25.
//

import Foundation

struct SWAPIUser: Identifiable, Codable {
    let id = UUID()
    let name: String
    let birth_year: String
}
