//
//  NFTViewModel.swift
//  TeleportMobile
//
//  Created by Rodney Gainous Jr on 6/26/24.
//

import Foundation

class NFTViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var isLoading = false
    
    func fetchNFTs() async {
        self.isLoading = true
        let urlString = "https://mainnet.helius-rpc.com/?api-key=e0743acb-70cd-49c8-8db0-c9b8470fa2e0"
        guard let url = URL(string: urlString) else { return }
        
        let body: [String: Any] = [
            "jsonrpc": "2.0",
            "id": "my-id",
            "method": "getAssetsByGroup",
            "params": [
                "groupKey": "collection",
                "groupValue": "5PA96eCFHJSFPY9SWFeRJUHrpoNF5XZL6RrE1JADXhxf",
                "page": 1,
                "limit": 1000
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async { self.isLoading = false }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async { self.isLoading = false }
                return
            }
            
            do {
                guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let result = jsonResult["result"] as? [String: Any],
                      let items = result["items"] as? [[String: Any]] else {
                    print("Invalid JSON structure")
                    DispatchQueue.main.async { self.isLoading = false }
                    return
                }
                
                let nfts = items.compactMap { item -> NFT? in
                    guard let id = item["id"] as? String,
                              let content = item["content"] as? [String: Any],
                              let metadata = content["metadata"] as? [String: Any],
                              let name = metadata["name"] as? String,
                              let description = metadata["description"] as? String,
                              let links = content["links"] as? [String: Any],
                              let imageURL = links["image"] as? String else {
                            print("Failed to parse NFT: \(item)")
                            self.isLoading = false
                            return nil
                    }
                    return NFT(id: id, name: name, imageURL: imageURL, description: description)
                }
                
                print("Parsed NFTs: \(nfts)")
                
                DispatchQueue.main.async {
                    self.nfts = nfts
                    self.isLoading = false
                }
            } catch {
                print("Failed to parse JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
