//
//  ArticleTableViewCell.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell, CellInterface {
    
    @IBOutlet private weak var articleTitleLabel: UILabel!
    
    func configure(with viewModel: ArticleCellViewModel) {
        articleTitleLabel.text = viewModel.title
    }
}
