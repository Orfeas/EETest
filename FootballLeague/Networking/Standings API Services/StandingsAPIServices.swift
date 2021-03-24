//
//  StandingsAPIServices.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

final class StandingsAPIServices {
    static let sharedQueue = OperationQueue()
    
    class func getStandingsForCompetionId(competitionId: String, success:((StandingsContext) -> Void)?, failure: ((APIError?) -> Void)?) {
        let getStandingsOperation = GetStandingsOperation(competitionId: competitionId) { response in
            guard let response = response as? [String: Any],
                  let standingsJson = response["standings"],
                  let standingsContext: StandingsContext = APIDeserializer<StandingsContext>.getDataModelFromResponse(response: standingsJson) else {
                failure?(APIError())
                return
            }
            
            success?(standingsContext)
        } failure: { error in
            failure?(error)
        }

        sharedQueue.addOperation(getStandingsOperation)
    }
}
