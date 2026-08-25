//
//  HomeView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 27/07/26.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    @State  var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader {geo in
            ScrollView(.vertical) {
                switch viewModel.homeStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                case .success:
                    LazyVStack {
                        AsyncImage(url: URL(string: heroTestTitle)){image in
                            image
                                .resizable()
                                .scaledToFit()
                                .overlay{
                                    LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),
                                                           Gradient.Stop(color: .gradient, location: 1)],
                                                   startPoint: .top,
                                                   endPoint: .bottom)
                                }
                            
                        } placeholder: {
                            ProgressView()
                        }.frame(width: geo.size.width,height: geo.size.height*0.85)
                        
                        
                        HStack{
                            Button{}label: {
                                
                                Text(Constants.playString)
                                    .ghostButton()
                                
                            }
                            Button{}label: {
                                Text(Constants.downloadString)
                                    .ghostButton()
                            }
                        }.padding(.top,10)
                        
                        HorizontalListView(header:Constants.trendingMovieString, titles:viewModel.trendingMovies)
                        HorizontalListView(header:Constants.trendingTvString, titles: viewModel.trendingTV)
                        HorizontalListView(header:Constants.topRatedMovieString, titles: viewModel.topRatedMovies)
                        HorizontalListView(header:Constants.topRatedTvString,titles: viewModel.topRatedTV)
                    }
                case .failed(let underlyingError):
                    Text("Error:\(underlyingError)")
                }
                
            }.task {
                await viewModel.getTitle()
            }
        }
    }
}

#Preview {
    HomeView()
}
