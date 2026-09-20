//
//  BlossomMovieApp.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 27/07/26.
//

import SwiftUI
import SwiftData

@main
struct BlossomMovieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Title.self)
    }
}
