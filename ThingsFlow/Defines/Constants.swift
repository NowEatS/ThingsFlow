//
//  Constants.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import Foundation

enum API {
    static let BASE_URL: String = "https://api.github.com/repos/"
}

enum TFContentsURL {
    static let ThingsFlow_Banner: String = "https://s3.ap-northeast-2.amazonaws.com/hellobot-kr-test/image/main_logo.png"
    static let ThingsFlow_WebSite: String = "http://thingsflow.com/ko/home"
}

enum UDKey {
    static let owner: String = "owner"
    static let repository: String = "repository"
}
