//
//  HorizontalListView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 04/08/26.
//

import SwiftUI

struct HorizontalListView: View {
    let header:String
    let titles = [Constants.testTitleURL,Constants.testTitleURL2, Constants.testTitleURL3]
    var body: some View {
        VStack(alignment: .leading){
            Text(header)
                .font(.title)
            
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(titles,id:\.self){title in
                        
                        AsyncImage(url: URL(string: title)){image in
                            
                            image
                                .resizable()
                                .scaledToFit()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width:120, height: 200)
                        
                    }
                }
                
            }
        }
        .frame(height: 250)
        .padding(10)
        
        
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMovieString)
}
