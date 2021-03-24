//
//  BaseNetworkingOperation.swift
//  GalleryScanDemo
//
//  Created by Orfeas Iliopoulos on 24/04/2018.
//  Copyright © 2018 Orfeas. All rights reserved.
//

import Foundation
import Alamofire

class BaseOperation: Operation {
    // MARK: - Variables

    private(set) var baseURL: URL!
    var method: HTTPMethod = .post
    var parameters: [String: Any]? = [:]
    var timeout = 30.0
    var path: String?
    var success: ((Any?) -> Void)?
    var failure: ((APIError?) -> Void)?
    var jsonBatch: String?
    var url: URL?
    var reqHeaders: HTTPHeaders?

    var operationIsFinished = false
    override var isFinished: Bool {
        get {
            return operationIsFinished
        }
        set {
            willChangeValue(forKey: "isFinished")
            operationIsFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }

    // MARK: - LifeCycle

    // Use baseURL only exceptionally
    init(baseURL: URL? = nil,
         path: String,
         method: HTTPMethod,
         parameters: [String: Any]?,
         jsonBatch: String? = nil,
         success: ((Any?) -> Void)?,
         failure: ((APIError?) -> Void)?) {
        super.init()
        if let base = baseURL {
            self.baseURL = base
        } else {
            self.baseURL = URL(string: "https://api.football-data.org")!
        }

        self.url = self.baseURL.flatMap {
            var pathString = ""
            if !path.isEmpty {
                pathString = "/" + encodedPathFromString(path: path)
            }
            return URL(string: $0.absoluteString + pathString)
        }
        self.path = path
        self.method = method
        self.parameters = parameters
        self.jsonBatch = jsonBatch
        self.success = success
        self.failure = failure
    }

    override init() {
        super.init()
    }

    override func main() {

        if isCancelled && url == nil {
            isFinished = true
            return
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout

        makeAPIRequest()

        if isCancelled && url == nil {
            isFinished = true
            return
        }
    }

    private func makeAPIRequest() {

        AF.request(url!,
                   method: method,
                   parameters: parameters as [String: AnyObject]?,
                   encoding: URLEncoding.default,
                   headers: getHeaders(nil)).responseJSON(completionHandler: { (responseObject) -> Void in
            self.process(dataResponse: responseObject)
            self.isFinished = true
        })
    }

    private func getHeaders(_ headers: [String: String]?) -> HTTPHeaders {
        var mutableHeaders = headers ?? [String: String]()

        // Check if there is a body in the request
        if parameters != nil || jsonBatch != nil {
            mutableHeaders["Content-Type"] = "application/json"
        }

        mutableHeaders["X-Auth-Token"] = "8303bd089e8b4a55ad8b48daea8e809a"

        reqHeaders = HTTPHeaders(mutableHeaders)

        return reqHeaders!
    }
    
    private func encodedPathFromString(path: String) -> String {
        var encodedPath = path
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:+@$,%#[] ").inverted)

        if let safePath = path.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            // do something with escaped string
            encodedPath = safePath
        }

        return encodedPath
    }
}

// MARK: - API request

extension BaseOperation {
    private func process(dataResponse: AFDataResponse<Any>) {
        switch dataResponse.result {
        case let .failure(error):
            if let statusCode = dataResponse.response?.statusCode {
                switch statusCode {
                case 200 ... 299:
                    success?(dataResponse.response)

                default:
                    failure?(APIError(error))
                }
            } else {
                failure?(APIError())
            }

        case let .success(response):

            if let statusCode = dataResponse.response?.statusCode {
                switch statusCode {
                case 200 ... 299:

                    success?(response)
                default:
                    failure?(APIError())
                }
            }
        }
    }
}
