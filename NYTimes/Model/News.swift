//
//  News.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import Foundation

struct News: Codable, Hashable {
    let status: String
    let copyright: String
    let results: [Results]
}

struct Results: Codable, Hashable {
    let section: String
    let title: String
    let url: String
    //let thumbnailStandard: String
    let multimedia: [Multimedia]?
    let publishedDate: String
}

struct Multimedia: Codable, Hashable {
    let url: String
}
