//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//
 
import SwiftUI
class MoviesViewModel: ObservableObject {
    @Published var movieResponse : MovieResponse = MovieResponse.init(page: nil, totalResults: nil, totalPages: nil, results: [])
    @Published var errorMessage  = ""
    @Published var state = ServiceStates.loading{
        didSet{
            if isFirstPage{
    
            }
        }
    }
    
    var isFirstPage = true
    
    func getPopularMovies(page:Int, completion: @escaping () -> Void) {
        isFirstPage = page == 0
        self.state = .loading
        
        let builder = DataExecuter.Movie.getPopularMovies(page: page).builder()
        DataExecuter.Request.init(builder: builder).execute(type: MovieResponse.self) { [weak self] (response, isSuccess, errorMessage) in
            if let data = response,isSuccess{
                if self?.isFirstPage ?? false {
                    self?.movieResponse = self?.setFavoritesFromLocal(movieResponse: data) ?? data
                }
                else{
                    self?.movieResponse.results.append(contentsOf: (self?.setFavoritesFromLocal(movieResponse: data) ?? data).results)
                }
                self?.state = .success
                completion()
            }
            else{
                self?.errorMessage = errorMessage ?? String.unExpectedError
                self?.state = .error
            }
        }
    }
    func setFavoritesFromLocal(movieResponse:MovieResponse) -> MovieResponse {
        let favoriteList = Helpers.getFavorites()
        for index in 0..<movieResponse.results.count {
            movieResponse.results[index].isFavorite = favoriteList.contains(movieResponse.results[index].id)
        }
        return movieResponse
    }
}
