//
//  GetTeamOperation.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 25/3/21.
//

import Foundation

final class GetTeamOperation: BaseOperation {
    init(teamId: String, success:((Any?) -> Void)?, failure: ((APIError?) -> Void)?) {
        
        super.init(path: "/v2/teams/\(teamId)", method: .get, parameters: nil, success: success, failure: failure)
    }
}
