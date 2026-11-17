
//
//  project2App.swift
//  project2
//
//  Created by Jabed Miah on 5/12/24.
//

import SwiftUI

/// API keys are read from Info.plist so they are never hardcoded in source.
/// Setup steps are in the README.
enum APIKeys {
    static let weather = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String ?? ""
    static let unsplash = Bundle.main.object(forInfoDictionaryKey: "UnsplashAccessKey") as? String ?? ""
}

@main
struct project2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
