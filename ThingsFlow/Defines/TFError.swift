//
//  TFError.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation

enum TFError: String, Error {
    case wrongOwnerOrReposiotry = "존재하지않는 소유자명 혹은 저장소명 입니다."
    case noIssueNumber = "해당 저장소에는 없는 이슈번호 입니다."
    
    case decodingFailure = "JSON 데이터 디코딩에 실패했습니다."
}
