//
//  ContentView.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NFTViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(viewModel.nfts) { nft in
                        NFTView(nft: nft)
                    }
                }.padding()
            }.navigationTitle("Tensorians NFTs")
        }.onAppear {
            viewModel.fetchNFTs()
        }
    }
}
