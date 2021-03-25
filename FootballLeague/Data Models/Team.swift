//
//  Team.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

typealias Teams = [Team]

class Team: Codable {
    var id: Int
    var name: String
    var crestUrl: String?
    var score: Int?
    var imageData: Data?
    
    var imageUrl: URL? {
        get {
            guard let crestUrl = self.crestUrl, let imageUrl = URL(string: crestUrl) else {
                return nil
            }
            
            return imageUrl
        }
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
