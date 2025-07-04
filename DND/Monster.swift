//
//  Monster.swift
//  DND
//
//  Created by Parimal Devi on 04/07/25.
//

import Foundation
struct Monster: Codable, Identifiable {
    let id = UUID().uuidString
    var index: String
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case index, name, url
    }
}
