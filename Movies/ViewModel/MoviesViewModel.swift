//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Sergio Altuzar on 31/07/25.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowPlayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    
    init() {
        getListUpcomingMovies()
        getMoviesNowPlaying()
        getTrendingMovies()
    }
    
    func getListUpcomingMovies() {
        NetworkManager.shared.getLisOfUpcomingMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case.success(let movies):
                    self.upcomingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplet:
                        print("Error unableToComplet")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getMoviesNowPlaying() {
        NetworkManager.shared.getMoviesNowPlaying { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case.success(let movies):
                    self.nowPlayingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplet:
                        print("Error unableToComplet")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getTrendingMovies() {
        NetworkManager.shared.getTrendingMovies { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case.success(let movies):
                    self.trendingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplet:
                        print("Error unableToComplet")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
}
