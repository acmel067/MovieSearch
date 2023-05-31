//
//  SearchResult.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
import Foundation

struct SearchResult: Codable {
    let page: Int
    let results: [Movie]?
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
