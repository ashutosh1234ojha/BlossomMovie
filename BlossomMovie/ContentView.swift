//
//  ContentView.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 27/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString,systemImage: Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString,systemImage: Constants.upcomingIconString){
             UpcomingView()
            }
            
            Tab(Constants.searchString,systemImage:Constants.seachIconString){
               SearchView()
            }
            
            Tab(Constants.downloadString, systemImage:Constants.downloadIconString) {
                DownloadView()
            }
        }
    }
}

#Preview {
    ContentView()
}
