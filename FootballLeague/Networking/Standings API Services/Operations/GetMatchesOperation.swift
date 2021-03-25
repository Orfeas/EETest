//
//  GetStandingsOperation.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation

final class GetMatchesOperation: BaseOperation {
    init(success:((Any?) -> Void)?, failure: ((APIError?) -> Void)?) {
        let toDate = Date().systemDateOnlyFormat()
        let fromDate = Date().addingTimeInterval(-(60 * 60 * 24 * 30)).systemDateOnlyFormat()
        
        super.init(path: "/v2/competitions/2021/matches?dateFrom=\(fromDate)&dateTo=\(toDate)&status=FINISHED", method: .get, parameters: nil, success: success, failure: failure)
    }
}
