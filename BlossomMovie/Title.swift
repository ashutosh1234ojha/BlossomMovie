//
//  Title.swift
//  BlossomMovie
//
//  Created by ashutosh ojha on 13/08/26.
//

import Foundation

struct APIObject: Decodable{
    var result :  [Title] = []
}

struct Title: Decodable, Identifiable {
    var id: Int?
    var title:String?
    var name:String?
    var overview: String?
    var posterPath: String?
}
