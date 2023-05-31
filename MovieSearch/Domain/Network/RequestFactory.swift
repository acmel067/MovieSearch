//
//  RequestFactory.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.cachePolicy = .useProtocolCachePolicy
        let token = AppConfig.apiAccessKey
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return request
    }
}

