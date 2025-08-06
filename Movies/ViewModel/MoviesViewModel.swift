//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Sergio Altuzar on 31/07/25.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [DataMovie] = []
    
    init() {
        getListUpcomingMovies()
    }
    
    func getListUpcomingMovies() {
        NetworkManager.shared.getLisOfUpcomingMovies { [weak self] result in
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
