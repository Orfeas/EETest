//
//  Match.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 25/3/21.
//

import Foundation

typealias Matches = [Match]

struct Match: Decodable {
    var homeTeam: Team
    var awayTeam: Team
    var score: Score
    
    var homeTeamWithScore: Team {
        get  {
            var team = self.homeTeam
            team.score = score.fullTime.homeTeam
            
            return team
        }
    }
    
    var awayTeamWithScore: Team {
        get  {
            var team = self.awayTeam
            team.score = score.fullTime.awayTeam
            
            return team
        }
    }
}
