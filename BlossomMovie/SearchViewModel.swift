//
//  SearchViewModel.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 18/09/26.
//

import Foundation

@Observable
class SearchViewModel {
    
    private(set) var errorMessage: String?
    private(set) var searchTitles: [Title] = []
    private let dataFetcher = DataFetcher()
    
    func getSearchTitles(by media:String, for title:String) async{
        do {
            errorMessage = nil
            if title.isEmpty {
                searchTitles =  try await dataFetcher.fetchTitle(for: media, by:"trending")
            }else {
                searchTitles =  try await dataFetcher.fetchTitle(for: media, by: "search", with: title)
            }
            
        }catch{
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
}
