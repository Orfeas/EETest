//
//  STNError.swift
//  SafeToNet
//
//  Created by Nikolaus Banjo on 26/11/2019.
//  Copyright © 2019 SafeToNet Ltd. All rights reserved.
//

import Foundation

public class APIError {
    
    var code: Int = 0
    var description: String = ""
    
    public init(_ errorString: String, statusCode: Int = 0 ) {
        code = statusCode
        description = errorString
    }
    
    public init(_ error: Error?) {
        guard let error = error else {return}
        code = (error as NSError).code
        
        description = error.localizedDescription
    }
    
    public init() {
    
    }

}


public extension APIError {
    func isRetryableError() -> Bool {
           return errorIsTimeOut(self)
       }

       private func errorIsTimeOut(_ error: APIError) -> Bool {
           return [
               NSURLErrorTimedOut,
               NSURLErrorCannotFindHost,
               NSURLErrorCannotConnectToHost,
               NSURLErrorNetworkConnectionLost,
               NSURLErrorNotConnectedToInternet,
               NSURLErrorDNSLookupFailed,
               408,
               504,
           ].contains(error.code)
       }
    
}
