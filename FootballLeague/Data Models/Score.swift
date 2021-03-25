//
//  Score.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 25/3/21.
//

import Foundation

struct Score: Decodable {
    var fullTime: GameTime
}

struct GameTime: Decodable {
    var homeTeam: Int
    var awayTeam: Int
}
