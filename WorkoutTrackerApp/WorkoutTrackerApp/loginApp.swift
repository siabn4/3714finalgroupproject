//
//  loginApp.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

@main
struct loginApp: App {
    @StateObject var taskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(taskViewModel)
        }
    }
}
