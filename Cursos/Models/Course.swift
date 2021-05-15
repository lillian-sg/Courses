//
//  Course.swift
//  Cursos
//
//  Created by Lilian on 15/05/21.
//

import Foundation

struct Course: Codable {
    var id: Int64?
    var name: String?
    var level: String?
       
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case level = "nivel"
        
    }
    
}
