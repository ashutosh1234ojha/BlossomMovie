//
//  ViewModel.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 16/08/26.
//

import Foundation

@Observable

class ViewModel{
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(underlyingError:Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    
    var trendingMovies:[Title] = []
    var trendingTV:[Title] = []
    var topRatedMovies:[Title] = []
    var topRatedTV:[Title] = []
    var heroTitle : Title = Title.previewTitles[0]
    var videoId = ""
    
    func getTitle() async {
        homeStatus = .fetching
        
        if trendingMovies.isEmpty{
            
            do{
                async let tMovies = dataFetcher.fetchTitle(for: "movie", by: "trending")
                async let tTV =  dataFetcher.fetchTitle(for: "tv", by: "trending")
                async let tRMovies =  dataFetcher.fetchTitle(for: "movie", by: "top_rated")
                async let tRTV =  dataFetcher.fetchTitle(for: "tv", by: "top_rated")
                
                trendingMovies =  try await tMovies
                trendingTV =  try await tTV
                topRatedMovies =  try await tRMovies
                topRatedTV =  try await tRTV
                
                if let title = trendingMovies.randomElement(){
                    heroTitle = title
                }
                
                homeStatus = .success
                
            }catch{
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
    }
    
    func getVideoId(for title: String) async {
        videoIdStatus = .fetching
        
        do{
            videoId =  try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        }catch{
            print(error)
            videoIdStatus = .failed(underlyingError: error)
        }
    }
}
