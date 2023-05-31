//
//  Movie.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
import Foundation


struct Movie: Codable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let plot: String?
    let backdropPath: String?
    let rating: Double
    var isFavorite: Bool {
        FavoritesManager.shared.contains(movie: self)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case plot = "overview"
        case releaseDate  = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
    }
    
    var releaseYear: Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let releaseDate, let date = dateFormatter.date(from: releaseDate) else {
            return nil
        }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return year
    }
    
    var imageURL: URL? {
        guard let path = posterPath else {
            return nil
        }

        return URL.imageAPIURL(with: path)
    }
    
    var backdropImageURL: URL? {
        guard let path = backdropPath else {
            return nil
        }
        
        return URL.imageAPIURL(with: path)
    }
}
