//
//  MovieDetailsViewModel.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/30/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
//

import UIKit

class MovieDetailsViewModel {
    
    private(set) var movie: Movie
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var updateComponents: (()->())?
    
    var movieDetails: MovieDetails? {
        didSet {
            DispatchQueue.main.async {
                self.updateComponents?()
            }
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // For fetching movie details
    func getMovieDetails() {
        let url = URL.movieDetailsAPIURL(with: movie.id)
        RequestService.shared.fetchData(url: url, type: MovieDetails.self, method: .GET) { result in
            switch result {
            case .success(let details):
                self.movieDetails = details
                break
            case .failure(let err):
                print(err)
                break
            }
        }
    }
    
    // Downloads the backdrop image asynchronously
    func downloadBackdropImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = movie.backdropImageURL else {
            completion(nil)
            return
        }
        
        RequestService.shared.downloadImage(from: url) { data in
            if let data {
                var image: UIImage?
                if let img = UIImage(data: data) {
                    image = img
                }
                completion(image)
            }
        }
    }
}
