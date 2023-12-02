//
//  MapApp.swift
//  Map
//
//  Created by Islombek Gofurov on 29.11.2023.
//

import SwiftUI
import SwiftData

@main
struct MapApp: App {
    var body: some Scene {
        WindowGroup {
            MapMainView()
        }
        .modelContainer(for: LocalItems.self)
    }
}
