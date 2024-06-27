//
//  TeleportMobileApp.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import SwiftUI

@main
struct TeleportMobileApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true

    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
