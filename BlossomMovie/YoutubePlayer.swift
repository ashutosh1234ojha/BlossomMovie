//
//  YoutubePlayer.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 27/08/26.
//

import Foundation
import WebKit
import SwiftUI


struct YoutubePlayer : UIViewRepresentable{
    let videoId: String
        let youtubeBaseURL: String? = APIConfig.shared?.youtubeBaseURL
        
        func makeUIView(context: Context) -> WKWebView {
            WKWebView()
        }
        
        func updateUIView(_ webView: WKWebView, context: Context) {
            guard let baseURLString = youtubeBaseURL,
                  let baseURL = URL(string: baseURLString) else {
                return
            }
            
            let fullURL = baseURL.appending(path: videoId)
            
            webView.load(URLRequest(url: fullURL))
        }
}
