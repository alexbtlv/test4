//
//  NewsResponseModel.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Foundation

struct NewsResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}
