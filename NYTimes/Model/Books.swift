//
//  Books.swift
//  NYTimes
//
//  Created by Ahmet Acar on 3.02.2021.
//

import Foundation


struct Books: Codable, Hashable {
    let results: BookResults
}

struct BookResults: Codable, Hashable {
    //let publishedDate: String
    let lists: [BookLists]
}

struct BookLists: Codable, Hashable {
    let listNameEncoded: String
    let displayName: String
    let listImage: String?
    let books: [BookInfo]?
}

struct BookInfo: Codable, Hashable {
    let author: String
    let bookImage: String
    let createdDate: String
    let description: String
    let publisher: String
    let rankLastWeek: Int?
    let rank: Int
    let buyLinks: [BuyLinks]
}

struct BuyLinks: Codable, Hashable {
    let name: String
    let url: String
}


