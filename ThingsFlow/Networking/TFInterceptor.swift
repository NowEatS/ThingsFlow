//
//  TFInterceptor.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation
import Alamofire

final class TFInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("TFInterceptor - adapt() called")
        
        var request = urlRequest
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("TFInterceptor - retry() called")
        
        completion(.doNotRetry)
    }
}
