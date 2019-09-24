//
//  APIManager.swift
//  iOSTechnicalTest
//
//  Created by Anson on 23/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (_ apiResponseHandler: ApiResponseHandler, _ error: Error?) -> Void

class APIManager {
    enum Router: URLConvertible {
        case getImage
        
        var path: String {
            switch self {
            // Inspire
            case .getImage:
                return ""
            }
        }
        
        func asURL() throws -> URL {
            
            let url = try Constants.baseURL.asURL()
            return url.appendingPathComponent(path)
        }
    }
    
    static let sharedInstance = APIManager()

    var defaultManager: Alamofire.SessionManager!

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        self.defaultManager = Alamofire.SessionManager(configuration: configuration)
        
    }
    
    func sendJSONRequest(method: HTTPMethod, path: URLConvertible, parameters: [String: Any]?, isAuthorized: Bool = true, token: String? = nil, completed: @escaping CompletionHandler) {
        
        var headers = ["": ""]
        headers = ["Content-Type": "application/json"]

        let baseParams: [String: Any] = ["key": "10961674-bf47eb00b05f514cdd08f6e11"]
        
        let updatedParams = baseParams.merged(with: parameters ?? [String: Any]())
        
        sendJSONRequest(method: method, path: path, parameters: updatedParams, encoding: URLEncoding.default, headers: headers, completed: completed)
        
    }
    
    // Common JSON Request
    private func sendJSONRequest(method: HTTPMethod, path: URLConvertible, parameters: [String: Any]?, encoding: ParameterEncoding, headers: [String: String], completed: @escaping CompletionHandler) {
        
        defaultManager.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(let data):
                    if let _ = response.response {
                        let apiResponseHandler: ApiResponseHandler = ApiResponseHandler(json: data)
                        completed(apiResponseHandler, nil)
                    }
                case .failure(let error):
                    let apiResponseHandler: ApiResponseHandler = ApiResponseHandler(json: nil)
                    completed(apiResponseHandler, error)
                }
        }
    }
}

// MARK: - Response Handler
struct ApiResponseHandler {
    var jsonObject: Any?
    var totalHits: Int?
    var hits: Any?
    var total: Int?
    init(json: Any?) {
        if let js = json {
            self.jsonObject = js
            let json = JSON(js)
            self.total = json["total"].int
            self.totalHits = json["totalHits"].int
            self.hits = json["hits"].arrayObject
        }
    }
}

