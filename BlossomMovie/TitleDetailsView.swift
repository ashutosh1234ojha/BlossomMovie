//
//  TitleDetailsView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 26/08/26.
//

import SwiftUI

struct TitleDetailsView: View {
    let title: Title
    var body: some View {
        GeometryReader{geometry in
            
            ScrollView{
                LazyVStack(alignment: .leading){
                    
                    AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width,height: geometry.size.height*0.85)
                    
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5)
                    
                    Text(title.overview ?? "")
                        .padding(5)
                    
                }
            }
            
        }
    }
}

#Preview {
    TitleDetailsView(title: Title.previewTitles[0])
}
