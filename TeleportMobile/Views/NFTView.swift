//
//  NFTView.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import SwiftUI

struct NFTView: View {
    let nft: NFT
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: nft.imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 150, height: 150).cornerRadius(10)
            
            Text(nft.name).font(.caption).lineLimit(1)
        }
    }
}
