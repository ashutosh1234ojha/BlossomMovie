//
//  YoutubeSearchResponse.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 31/08/26.
//

import Foundation

struct YoutubeSearchResponse : Codable {
    let items: [ItemProperties]?
}

struct ItemProperties : Codable {
    let id: IdProperties?
}

struct IdProperties:Codable{
    let videoId: String?
}
