//
//  SplashScreen.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var rotation: Double = 0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        ForEach(0..<3) { i in
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue.opacity(0.7), lineWidth: 5)
                                .frame(width: 100, height: 140)
                                .rotationEffect(.degrees(Double(i) * 60))
                                .rotationEffect(.degrees(rotation))
                        }
                        
                        Image("tensorians")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    
                    Text("Tensorians NFTs")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .scaleEffect(size)
                        .opacity(opacity)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                    self.rotation = 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
