//
//  Team.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

typealias StandingsContext = [StandingContext]

struct StandingContext: Decodable {
    var type: String
    var table: Standings
}

typealias Standings = [Standing]

struct Standing: Decodable {
    var team: Team
    var won: Int
}
