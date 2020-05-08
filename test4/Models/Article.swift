//
//  Post.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
//    let url: String?
//    let urlToImage: String?
//    let publishedAt: Date?
    let content: String?

//    enum CodingKeys: String, CodingKey {
//        case source, author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
}
