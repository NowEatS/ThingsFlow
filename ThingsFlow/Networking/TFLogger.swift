//
//  TFLogger.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation
import Alamofire

final class TFLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "TFLogger")
    
    func requestDidResume(_ request: Request) {
        print("TFLogger - requestDidResume()")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("TFLogger - requestDidParseRequest()")
        debugPrint(response)
    }
}
