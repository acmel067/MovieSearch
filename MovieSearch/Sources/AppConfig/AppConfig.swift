//
//  AppConfig.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

enum ConfigKeys {
    static let apiAccessKey: String = "API_ACCESS_KEY"
}

struct AppConfig {
    static let apiAccessKey: String = Bundle.getBundleInfo(for: ConfigKeys.apiAccessKey)
    static let themoviedbAPIURL: String = "https://api.themoviedb.org"
    static let themoviedbImageURL: String = "https://image.tmdb.org/t/p/w500"
}

struct Strings {    
    struct Error {
        static let noFavorites = "No favorites found"
        static let noSearchResult = "No search result found"
    }
}
