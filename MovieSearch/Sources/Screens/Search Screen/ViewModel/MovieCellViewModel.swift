//
//  MovieImageViewModel.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    private(set) var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var imageData: Data?

    var title: String {
        return movie.title ?? ""
    }
    
    var plot: String {
        return movie.plot ?? ""
    }
    
    var imageURL: URL? {
        return movie.imageURL
    }
    
    var movieID: Int {
        return movie.id
    }
        
    var releaseYear: String {
        guard let year = movie.releaseYear else {
            return ""
        }
        return String(year)
    }
    
    // Downloads the backdrop image asynchronously
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        if let imageData, let img = UIImage(data: imageData) {
            completion(img)
        } else {
            guard let url = movie.imageURL else {
                completion(nil)
                return
            }
                        
            RequestService.shared.downloadImage(from: url) { [weak self] data in
                if let data {
                    self?.imageData = data
                    var image: UIImage?
                    if let img = UIImage(data: data) {
                        image = img
                    }
                    completion(image)
                }
            }
            
        }
    }
}
