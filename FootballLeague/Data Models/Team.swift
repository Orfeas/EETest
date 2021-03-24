//
//  Team.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

typealias Teams = [Team]

struct Team: Decodable {
    var id: Int
    var name: String
    var crestUrl: String
    
    var imageUrl: URL? {
        get {
            guard let imageUrl = URL(string: crestUrl) else {
                return nil
            }
            
            return imageUrl
        }
    }
}
