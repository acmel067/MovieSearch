//
//  URL+Extension.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

extension URL {
    static func imageAPIURL(with path: String) -> URL? {
        return URL(string: AppConfig.themoviedbImageURL + path)
    }
    
    static func movieSearchAPIURL(with movie: String, at page: Int) -> URL? {
        return URL(string: AppConfig.themoviedbAPIURL + "/3/search/movie?query=\(movie)&page=\(page)")
    }
    
    static func movieDetailsAPIURL(with id: Int) -> URL? {
        return URL(string: AppConfig.themoviedbAPIURL + "/3/movie/\(id)?append_to_response=credits")
    }
}
