//
//  FavoritesManager.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation


class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    private let userDefaults = UserDefaults.standard
    private let moviesKey = "favorite-movies"
    
    private init() {}
    
    func appendMovie(_ movie: Movie?) {
        guard let movie else { return }
        
        var movies = retrieveMovies()
        movies.append(movie)
        saveMovies(movies)
    }
    
    func retrieveMovies() -> [Movie] {
        guard let moviesData = userDefaults.data(forKey: moviesKey) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode([Movie].self, from: moviesData)
            return movies
        } catch {
            print("Error decoding movie data: \(error)")
            return []
        }
    }
    
    private func saveMovies(_ movies: [Movie]) {
        do {
            let encoder = JSONEncoder()
            let moviesData = try encoder.encode(movies)
            userDefaults.set(moviesData, forKey: moviesKey)
        } catch {
            print("Error encoding movie data: \(error)")
        }
    }
    
    func remove(movie: Movie?) {
        guard let movie else { return }
        
        var movies = retrieveMovies()
        movies.removeAll {
            $0.id == movie.id
        }
        saveMovies(movies)
    }
    
    func contains(movie: Movie) -> Bool {
        let movies = retrieveMovies()
        return movies.contains {
            $0.id == movie.id
        }
    }    
}
