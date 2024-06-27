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
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if showSplash {
                    SplashScreen().transition(.opacity).zIndex(1).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
                }
            }.preferredColorScheme(.dark)
        }
    }
}
