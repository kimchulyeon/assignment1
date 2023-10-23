//
//  URLSessionManager.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

final class URLSessionManager {
    static let shared = URLSessionManager()
    var session: URLSession!
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        config.networkServiceType = .responsiveData
        session = URLSession(configuration: config)
    }
}
