//
//  StandingsAPIServices.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

final class MatchesAPIServices {
    static let sharedQueue = OperationQueue()
    
    class func getMatches(success:((Matches) -> Void)?, failure: ((APIError?) -> Void)?) {
        let getMatchesOperation = GetMatchesOperation { response in
            guard let response = response as? [String: Any],
                  let matchesJson = response["matches"],
                  let matches: Matches = APIDeserializer<Matches>.getDataModelFromResponse(response: matchesJson) else {
                failure?(APIError())
                return
            }
            
            success?(matches)
        } failure: { error in
            failure?(error)
        }

        sharedQueue.addOperation(getMatchesOperation)
    }
    
    class func getTeamForId(teamId: String, success:((Team) -> Void)?, failure: ((APIError?) -> Void)?) {
        let getMatchesOperation = GetTeamOperation(teamId: teamId) { response in
            guard let response = response as? [String: Any],
                  let team: Team = APIDeserializer<Team>.getDataModelFromResponse(response: response) else {
                failure?(APIError())
                return
            }
            
            success?(team)
        } failure: { error in
            failure?(error)
        }

        sharedQueue.addOperation(getMatchesOperation)
    }
}
