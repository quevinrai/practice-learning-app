//
//  Learning_App.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/20/23.
//

import SwiftUI

@main
struct Learning_App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
