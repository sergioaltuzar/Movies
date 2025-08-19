//
//  MoviesView.swift
//  Movies
//
//  Created by Sergio Altuzar on 31/07/25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var gridItemLayout = [GridItem(.flexible())]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Proximos estrenos")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    AsyncImage(url: URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)")) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .cornerRadius(12)
                                    .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                    
                    Text("Ahora en cartelera")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.nowPlayingMovies, id: \.id) { movie in
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    AsyncImage(url: URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)")) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .cornerRadius(12)
                                    .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                    
                    Text("Tendencias")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.trendingMovies, id: \.id) { movie in
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    AsyncImage(url: URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)")) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .cornerRadius(12)
                                    .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    MoviesView()
}
