//
//  NFTViewModel.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import Foundation

class NFTViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    
    func fetchNFTs() {
        let urlString = "https://api.helius.xyz/v0/token-metadata?api-key=e0743acb-70cd-49c8-8db0-c9b8470fa2e0"
        guard let url = URL(string: urlString) else { return }
        
        let body: [String: Any] = [
            "mintAccounts": ["5PA96eCFHJSFPY9SWFeRJUHrpoNF5XZL6RrE1JADXhxf"],
            "includeOffChain": true,
            "disableCache": false
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let nfts = try decoder.decode([NFT].self, from: data)
                DispatchQueue.main.async {
                    self.nfts = nfts
                }
            } catch {
                print("Error decoding NFTs: \(error)")
            }
        }.resume()
    }
}
