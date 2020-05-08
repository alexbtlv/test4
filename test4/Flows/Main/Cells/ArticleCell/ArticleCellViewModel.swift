//
//  ArticleCellViewModel.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Foundation

final class ArticleCellViewModel {
    
    let title: String
    
    init(article: Article) {
        self.title = article.title ?? "Empty title"
    }
}
