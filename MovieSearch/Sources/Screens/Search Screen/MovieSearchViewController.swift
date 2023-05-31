//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
//

import UIKit

enum ScreenMode {
    case favorites
    case search
}

class MovieSearchViewController: UIViewController {

    @IBOutlet private weak var movieSearchBar: UISearchBar!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var favorites: UIButton!
    
    var movieSearchViewModel = MovieSearchViewModel()
    var mode: ScreenMode = .favorites {
        didSet {
            updateScreen(mode: mode)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        setupDisplay()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if mode == .favorites {
            movieSearchViewModel.getFavorites()
        }
    }
    
    func setupDisplay() {
        showError(show: false)
        updateScreen(mode: mode)
    }
    
    func initViewModel() {
        movieSearchViewModel.reloadTableView = {
            DispatchQueue.main.async {
                let isThereResult = self.movieSearchViewModel.numberOfCells > 0
                if isThereResult {
                    self.moviesCollectionView.reloadData()
                }
                self.showError(show: !isThereResult)
            }
        }
    }
    
    func showError(show: Bool) {
        errorView.isHidden = !show
        moviesCollectionView.isHidden = show
    }
    
    func updateScreen(mode: ScreenMode) {
        movieSearchViewModel.switchMode(mode: mode)
        switch mode {
        case .favorites:
            movieSearchBar.resignFirstResponder()
            movieSearchBar.text = ""
            errorLabel.text = Strings.Error.noFavorites
        case .search:
            errorLabel.text = Strings.Error.noSearchResult
        }
        favorites.isSelected = mode == .search
    }
}

extension MovieSearchViewController {
    @IBAction func changeScreenMode (sender: UIButton?) {
        switch mode {
        case .favorites:
            mode = .search
        case .search:
            mode = .favorites
        }
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieSearchViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.identifier,
            for: indexPath
        ) as? MovieCell else {
            fatalError("Cell cannot be found")
        }
        
        cell.configure(with: movieSearchViewModel.getCellViewModel(at: indexPath))
        if mode == .search {
            movieSearchViewModel.loadMoreMoviesIfNeeded(withIndexpath: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moviesCollectionView.deselectItem(at: indexPath, animated: true)
        let movieDetailsViewModel = movieSearchViewModel.initMovieDetailsViewModel(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as? MovieDetailsViewController {
            detailsViewController.setDetailsViewModel(with: movieDetailsViewModel)
            detailsViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        movieSearchViewModel.resetForNewMovieSearch()
        movieSearchViewModel.loadMovies(withTitle: text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if mode == .search {
            return
        }
        mode = .search
    }
}
