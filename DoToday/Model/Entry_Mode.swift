//
//  Entry_Mode.swift
//  DoToday
//
//  Created by David Adekunle on 28/10/2026.
//

import Foundation

struct DailyEntry : Identifiable, Codable, Hashable{
    let id : UUID
    var title : String
    var body : String
    var isHappy : Bool
    var createdAt : Date
    var userId : UUID
    var image : String
    
    enum CodingKeys : String, CodingKey{
        case id
        case title = "entry_title"
        case body = "entry_body"
        case isHappy = "is_happy"
        case createdAt = "created_at"
        case userId = "user_id"
        case image = "entry_image"
    }
}
