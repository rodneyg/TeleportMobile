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
            ZStack {
                if viewModel.isLoading && viewModel.nfts.isEmpty {
                    loadingView
                } else if viewModel.nfts.isEmpty {
                    emptyGridView
                } else {
                    nftGridView
                }
            }.navigationTitle("Tensorians NFTs").refreshable {
                await viewModel.fetchNFTs()
            }
        }.onAppear {
            if viewModel.nfts.isEmpty {
                Task {
                    await viewModel.fetchNFTs()
                }
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            Image(systemName: "hourglass").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("Loading...")
        }
    }
    
    private var emptyGridView: some View {
        VStack {
            Image(systemName: "square.grid.3x3").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100).foregroundColor(.gray)
            Text("No NFTs found").font(.headline).foregroundColor(.gray)
        }
    }
    
    private var nftGridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(viewModel.nfts) { nft in
                    NFTView(nft: nft)
                }
            }.padding()
        }
    }
}
