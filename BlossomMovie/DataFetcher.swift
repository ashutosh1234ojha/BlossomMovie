//
//  DataFetcher.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 15/08/26.
//

import Foundation

let tmbdBaseUrl =  APIConfig.shared?.tmdbBaseURL
let tmbdApiKey =  APIConfig.shared?.tmdbAPIKey


func fetchTitle(for media:String) async throws-> [Title] {
    guard let baseUrl = tmbdBaseUrl else{
        throw NetworkError.missingConfig
    }
    
    guard let apiKey = tmbdApiKey else{
        throw NetworkError.missingConfig
    }
    
   guard let fetchTitleUrl = URL(string: baseUrl)?
        .appending(path: "3/trending\(media)/day")
        .appending(queryItems: [URLQueryItem(name:"api_key",value:apiKey)]) else{
       throw NetworkError.urlBuildFailed
   }
    
    print(fetchTitleUrl)
    
    let (data,urlResponse) = try await URLSession.shared.data(from: fetchTitleUrl)
   
    guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
       throw NetworkError.badURLResponse(underlyingError:NSError(
            domain: "DataFetcher",
            code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
            userInfo:[NSLocalizedDescriptionKey:"Invalid HTTTP Response"]))
    }
    
    let decoder =  JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(APIObject.self, from: data).result
}
