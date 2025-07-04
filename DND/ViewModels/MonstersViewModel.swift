//
//  MonstersViewModel.swift
//  DND
//
//  Created by Parimal Devi on 04/07/25.
//

import Foundation

@Observable

class MonstersViewModel {
    struct Results: Codable {
        var count: Int
        var results: [Monster]
    }
    
    var count: Int = 0
    var monsters: [Monster] = []
    let baseURL = "https://www.dnd5eapi.co"
    var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
    var isLoading = false
    
    func getData() async {
        isLoading = true
        print("🕸️ We are acessing the url \(urlString)")
        guard let url = URL(string: urlString) else {
            print("😡 Error: Could not conver url \(urlString) to a valid URL")
            isLoading = false
            return
        }
        do {
            let configuration = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: configuration)
            let (data, _) = try await session.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Results.self, from: data) else {
                print("😡 JSON Error: Could not decode JSON from data at \(urlString) ")
                isLoading = false
                return
            }
            print("😎 JSON Returned: We have just returned \(returned.results.count) monsters")
            
            Task {@MainActor in
                self.count = returned.count
                self.monsters = returned.results
                isLoading = false
            }
            
        } catch {
            isLoading = false
            print("😡 Error: Could not get data from \(urlString) \(error.localizedDescription)")
        }
    }
}
