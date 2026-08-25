//
//  DataFetcher.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 15/08/26.
//

import Foundation

struct DataFetcher {
    
    let tmbdBaseUrl =  APIConfig.shared?.tmdbBaseURL
    let tmbdApiKey =  APIConfig.shared?.tmdbAPIKey
    
    
    func fetchTitle(for media:String, by type:String) async throws-> [Title] {
 
        let fetchTitleURL = try buildUrl(media: media, type: type)
        
        guard let fetchTitleURL = fetchTitleURL else {
           throw NetworkError.urlBuildFailed
        }
    
            let (data,urlResponse) = try await URLSession.shared.data(from: fetchTitleURL)
            
            guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
                throw NetworkError.badURLResponse(underlyingError:NSError(
                    domain: "DataFetcher",
                    code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                    userInfo:[NSLocalizedDescriptionKey:"Invalid HTTTP Response"]))
            }
            
            let decoder =  JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            var titles = try decoder.decode(APIObject.self, from: data).results
            Constants.addPosterPath(to: &titles)
            return titles
            
        }
    
    private func buildUrl(media:String, type:String) throws -> URL?{
        guard let baseUrl = tmbdBaseUrl else{
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmbdApiKey else{
            throw NetworkError.missingConfig
        }
        
        var path:String
        
        if type == "trending"{
            path = "3/trending/\(media)/day"
        } else if type == "top_rated"{
            path = "3/\(media)/top_rated"
        }else{
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: [URLQueryItem(name:"api_key",value:apiKey)]) else{
                throw NetworkError.urlBuildFailed
            }
                
        return url
    }
}
