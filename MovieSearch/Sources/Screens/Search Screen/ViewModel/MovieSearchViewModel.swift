//
//  MovieSearchViewModel.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//
//

import Foundation


class MovieSearchViewModel {
    
    var movies: [Movie] = [Movie]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    var currentPage: Int = 1
    var movieToSearch = String()
    var totalPages: Int = 0
    
    private var cellViewModels: [MovieCellViewModel] = [MovieCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }

    // resets properties for new movie search
    func resetForNewMovieSearch() {
        cellViewModels = []
        currentPage = 1
    }
    
    // fetches movies if there are still pages for movies to be fetched
    func loadMoreMoviesIfNeeded(withIndexpath indexPath: IndexPath) {
        if indexPath.row == numberOfCells - 1 &&
            currentPage < totalPages {
            currentPage += 1
            loadMovies(withTitle: movieToSearch)
        }
    }
    
    // fetches movies
    func loadMovies(withTitle title: String) {
        movieToSearch = title
        let url = URL.movieSearchAPIURL(with: title, at: currentPage)
        RequestService.shared.fetchData(url: url, type: SearchResult.self, method: .GET) { [weak self] result in
            switch result {
            case .success(let searchResult):
                guard let results = searchResult.results else {
                    fatalError("Error in fetching search result")
                    break
                }
                
                self?.cellViewModels.append(contentsOf: results.compactMap({
                    MovieCellViewModel(movie: $0)
                }))
                
                self?.totalPages = searchResult.totalPages
                break
            case .failure(let err):
                print(err)
                break
            }
        }
    }
    
    // reset properties and update screen based on screen mode
    func switchMode(mode: ScreenMode) {
        resetForNewMovieSearch()
        switch mode {
        case .favorites:
            getFavorites()
        case .search:
            break;
        }
    }
    
    // gets the list of stored favorites
    func getFavorites() {
        let movies = FavoritesManager.shared.retrieveMovies()
        self.cellViewModels = movies.compactMap({
            MovieCellViewModel(movie: $0)
        })
    }

    // gets the view model of a movie at index
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    // initialize movie details viewmodel
    func initMovieDetailsViewModel(at indexPath: IndexPath) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movie: cellViewModels[indexPath.row].movie)
    }
}
