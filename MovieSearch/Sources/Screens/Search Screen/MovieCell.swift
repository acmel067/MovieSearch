//
//  MovieImageCell.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
//

import UIKit

final class MovieCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseYearLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    static let identifier = "MovieCell"
    
    func configure(with viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        releaseYearLabel.text = viewModel.releaseYear
        plotLabel.text = viewModel.plot
        movieImageView.image = UIImage(named: "no-image")
        ratingLabel.text = String(format: "%.2f", viewModel.movie.rating)
        self.movieImageView.cornerRadius(10)
        
        let vm = viewModel
        if let data = viewModel.imageData {
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }            
        } else {
            vm.downloadImage { [weak self] image in
                if let image {
                    self?.movieImageView.image = image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImageView.image = nil
    }
}
