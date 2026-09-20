//
//  DownloadView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 20/09/26.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query var savedTitles : [Title]
    var body: some View {
        NavigationStack{
            if savedTitles.isEmpty{
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            } else{
                VerticalListView(titles: savedTitles)
            }
        }
    }
}

#Preview {
    DownloadView()
}
