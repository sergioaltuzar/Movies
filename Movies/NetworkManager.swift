//
//  NetworkManager.swift
//  Movies
//
//  Created by Sergio Altuzar on 31/07/25.
//

import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplet
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=b72deee0247dc9fd0a6e9c73fb5d2e6b&language=es-MX&page=1"
    
    static let nowPlaying =
    "https://api.themoviedb.org/3/movie/now_playing?api_key=b72deee0247dc9fd0a6e9c73fb5d2e6b&language=es-MX&page=1"
    
    static let trending =
    "https://api.themoviedb.org/3/trending/all/day?api_key=2cfa8720256036601fb9ac4e4bce1a9b"
    
    func getLisOfUpcomingMovies(completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.upcoming) else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplet))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getMoviesNowPlaying(completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.nowPlaying) else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplet))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
}



struct Constants {
    static let urlImages = "https://image.tmdb.org/t/p/original"
    static let placeholder = "https://cringemdb.com/img/movie-poster-placeholder.png"
    static let urlTrailer = "uxRm9UiJOPY&t=12s"
}
