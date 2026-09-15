//
//  SearchView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 15/09/26.
//

import SwiftUI

struct SearchView: View {
    var titles = Title.previewTitles
    @State private var searchByMovies = true
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]){
                    ForEach(titles){title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                            image.resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }.frame(width: 120, height: 150)
                }
            }
            .navigationTitle(searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        searchByMovies.toggle()
                    } label: {
                        Image(systemName: searchByMovies ? Constants.movieIconString : Constants.tvIconString)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
