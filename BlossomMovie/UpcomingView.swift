//
//  UpcomingView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 07/09/26.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        VerticalListView(titles: Title.previewTitles)
    }
}

#Preview {
    UpcomingView()
}
