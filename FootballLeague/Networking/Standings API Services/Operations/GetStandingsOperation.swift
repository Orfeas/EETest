//
//  GetStandingsOperation.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

final class GetStandingsOperation: BaseOperation {
    init(competitionId: String, success:((Any?) -> Void)?, failure: ((APIError?) -> Void)?) {
        super.init(path: "/v2/competitions/\(competitionId)/standings", method: .get, parameters: nil, success: success, failure: failure)
    }
}
