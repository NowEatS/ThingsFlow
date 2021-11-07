//
//  TFSearchRouter.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation
import Alamofire

enum TFSearchRouter: URLRequestConvertible {
    // Case
    case searchIssueList(owner: String, repository: String)
    
    private var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    private var method: HTTPMethod {
        switch self {
        case .searchIssueList:
            return .get
        }
    }
    
    private var endpoint: String {
        switch self {
        case let .searchIssueList(owner, repository):
            return owner + "/" + repository + "/issues"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint)
        
        print("TFSearchRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
