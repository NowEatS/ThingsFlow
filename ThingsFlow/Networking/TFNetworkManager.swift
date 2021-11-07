//
//  TFNetworkManager.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation
import Alamofire

final class TFNetworkManager {
    // 싱글톤
    static let shared: TFNetworkManager = TFNetworkManager()
    
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
    // 인터셉터
    let interceptors: Interceptor = Interceptor(interceptors:[])
    
    // 로거
    let monitors: [EventMonitor] = [TFLogger()] as [EventMonitor]
    
    // 세션
    var session: Session
    
    // Request Methods
    func getIssueList(owner: String, repository: String, completion: @escaping (Result<[Issue], TFError>) -> Void) {
        print("TFNetworkManager - getIssueList() called owner: \(owner), repository: \(repository)")
        
        session
            .request(TFSearchRouter.searchIssueList(owner: owner, repository: repository))
            .validate(statusCode: 200..<401)
            .responseJSON { response in
                
                if response.response?.statusCode == 404 {
                    completion(.failure(.wrongOwnerOrReposiotry))
                    return
                }
                
                guard let responseData = response.data else { return }
                
                do {
                    let issues: [Issue] = try JSONDecoder().decode([Issue].self, from: responseData)
                    completion(.success(issues))
                    return
                } catch {
                    completion(.failure(.decodingFailure))
                    return
                }
            }
    }
}
