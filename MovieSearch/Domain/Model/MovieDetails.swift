//
//  MovieDetails.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
import Foundation

struct MovieDetails: Codable {
    var title: String?
    var releaseDate: String?
    var runTime: Int?
    var plot: String?
    var rating: Double?
    var genre: [Genre]?
    var credits: Credits?
    
    enum CodingKeys: String, CodingKey {
        case title
        case genre = "genres"
        case credits
        case releaseDate = "release_date"
        case runTime = "runtime"
        case plot = "overview"
        case rating = "vote_average"
    }
    
    var actors: [Cast] {
        guard let cast = credits?.cast else {
            return [Cast]()
        }
        
        return Array(cast.prefix(5))
    }
    
    var genres: [Genre] {
        guard let genre = genre else {
            return [Genre]()
        }
        
        return Array(genre.prefix(3))
    }
    
    var runTimeInHours: (String) {
        guard let runTime = runTime else {
            return ""
        }
        
        let  time = runTime.convertToHoursAndMinutes()
        return "\(time.hours)h \(time.minutes)min"
    }
    
    var director: [Crew] {
        guard let cast = credits?.crew else {
            return [Crew]()
        }
        
        return cast.filter {
            $0.job == "Director"
        }
    }
}

struct Genre: Codable {
    let name: String?
}

struct Cast: Codable {
    let id: Int
    let name: String?
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}

struct Crew: Codable {
    let id: Int
    let name: String?
    let job: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case job
        case profilePath = "profile_path"
    }
}

struct Credits: Codable {
    let cast: [Cast]?
    let crew: [Crew]?
}

