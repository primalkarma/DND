//
//  MonsterDetail.swift
//  DND
//
//  Created by Parimal Devi on 04/07/25.
//

import Foundation

struct MonsterDetail: Codable {
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hit_points: Int = 0
    var image: String? = ""
    
}
