//
//  MovieDetailsViewController.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var plotTitleLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    @IBOutlet private weak var castTitleLabel: UILabel!
    @IBOutlet private weak var castLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var addToFavorite: UIButton!
    
    static let identifier = "MovieDetailsViewController"
    
    var movieDetailsViewModel: MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        initViewModel()
        getAndSetBackdropImage()
        getMovieDetails()
    }
    
    func getAndSetBackdropImage() {
        movieDetailsViewModel?.downloadBackdropImage(completion: { [weak self] image in
            DispatchQueue.main.async {
                if let image {
                    self?.movieImageView.image = image
                } else {
                    self?.movieImageView.image = UIImage(named: "no-image")
                }
            }
        })
    }
    
    func setDetailsViewModel(with viewModel: MovieDetailsViewModel) {
        movieDetailsViewModel = viewModel
    }
    
    func setup() {
        movieTitleLabel.text = movieDetailsViewModel?.movie.title
        ratingLabel.text = String(format: "%.2f", movieDetailsViewModel?.movie.rating ?? 0.0)
        plotLabel.text = movieDetailsViewModel?.movie.plot
        addToFavorite.isSelected = movieDetailsViewModel?.movie.isFavorite ?? false
    }
    
    func initViewModel() {
        movieDetailsViewModel?.updateComponents = { [weak self] in
            let  runtime = self?.movieDetailsViewModel?.movieDetails?.runTimeInHours
            let genres = self?.movieDetailsViewModel?.movieDetails?.genres.map({
                $0.name ?? ""
            }).joined(separator: ", ")
            self?.runtimeLabel.text =  "\(runtime ?? "")   |  \(genres ?? "")"
            self?.castLabel.text = self?.movieDetailsViewModel?.movieDetails?.actors.map({
                $0.name ?? ""
            }).joined(separator: ", ")
            
            self?.directorLabel.text = self?.movieDetailsViewModel?.movieDetails?.director.map({
                $0.name ?? ""
            }).joined(separator: ", ")
        }
    }
    
    func getMovieDetails() {
        movieDetailsViewModel?.getMovieDetails()
    }
    
    @IBAction func addToFavoritesDidTap(sender: UIButton) {
        if addToFavorite.isSelected {
            FavoritesManager.shared.remove(movie: movieDetailsViewModel?.movie)
        } else {            
            FavoritesManager.shared.appendMovie(movieDetailsViewModel?.movie)
        }
        
        addToFavorite.isSelected = !addToFavorite.isSelected
    }
}
