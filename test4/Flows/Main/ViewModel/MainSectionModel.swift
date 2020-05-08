//
//  MainSectionModel.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Foundation
import RxDataSources

enum MainSectionModel {
    case main(items: [MainSectionItem])
}

enum MainSectionItem {
    case article(cellViewModel: ArticleCellViewModel)
}

extension MainSectionModel: SectionModelType {
    
    typealias Item = MainSectionItem
    
    var items: [MainSectionItem] {
        switch self {
        case .main(let items):
            return items
        }
    }
    
    init(original: MainSectionModel, items: [MainSectionItem]) {
        switch original {
        case .main(let items):
            self = .main(items: items)
        }
    }
}
