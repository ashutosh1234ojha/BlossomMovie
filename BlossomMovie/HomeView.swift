//
//  HomeView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 27/07/26.
//

import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader {geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView().frame(width: geo.size.width,height: geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")){image in
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
                                Button{
                                    titleDetailPath.append(viewModel.heroTitle)
                                }label: {
                                    
                                    Text(Constants.playString)
                                        .ghostButton()
                                    
                                }
                                Button{}label: {
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                }
                            }.padding(.top,10)
                            
                            HorizontalListView(header:Constants.trendingMovieString, titles:viewModel.trendingMovies){title in
                                titleDetailPath.append(title)
                                
                            }
                            HorizontalListView(header:Constants.trendingTvString, titles: viewModel.trendingTV){title in
                                titleDetailPath.append(title)
                                
                            }
                            HorizontalListView(header:Constants.topRatedMovieString, titles: viewModel.topRatedMovies){title in
                                titleDetailPath.append(title)
                                
                            }
                            HorizontalListView(header:Constants.topRatedTvString,titles: viewModel.topRatedTV){title in
                                titleDetailPath.append(title)
                                
                            }
                        }
                        
                        
                    case .failed(let underlyingError):
                        Text("Error:\(underlyingError)")
                    }
                    
                }.task {
                    await viewModel.getTitle()
                }
            }
            .navigationDestination(for: Title.self){title in
                TitleDetailsView(title: title)
            }
        }
    }
}

#Preview {
    HomeView()
}
