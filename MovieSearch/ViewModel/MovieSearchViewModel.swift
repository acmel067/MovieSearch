//
//  MovieSearchViewModel.swift
//  MovieSearch
//
//  Created by Acuba, Melody on 5/27/23.
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

    
    func resetForNewMovieSearch() {
        cellViewModels.removeAll()
        currentPage = 1
    }
    
    func loadMoreMoviesIfNeeded(withIndexpath indexPath: IndexPath) {
        if indexPath.row == numberOfCells - 1 &&
            currentPage < totalPages {
            currentPage += 1
            loadMovies(withTitle: movieToSearch)
        }
    }
    
    func loadMovies(withTitle title: String) {
        movieToSearch = title
        let urlString = "https://api.themoviedb.org/3/search/movie?query=\(title)&include_adult=false&page=\(currentPage)"
        RequestService.shared.fetchData(urlString: urlString, type: SearchResult.self, method: .GET) { [weak self] result in
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

    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func initMovieDetailsViewModel(at indexPath: IndexPath) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movie: cellViewModels[indexPath.row].movie)
    }
}
