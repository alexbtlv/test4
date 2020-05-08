//
//  MainViewModel.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Moya
import RxCocoa

final class MainViewModel {
    
    // MARK: Private properties
    private let provider: MoyaProvider<APIProvider>
    
    // MARK: Public properties
    let currentPage = BehaviorRelay(value: 1)
    let isLoading: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    let articles: BehaviorRelay<[Article]> = BehaviorRelay(value: [])
    
    init() {
        self.provider = MoyaProvider<APIProvider>()
        getNews()
    }
    
    private func getNews() {
        isLoading.accept(true)
        provider.request(.getNews(page: currentPage.value)) { [weak self] (result) in
            self?.isLoading.accept(false)
            switch result {
            case .success(let response):
                if let news = try? JSONDecoder().decode(NewsResponseModel.self, from: response.data) {
                    self?.articles.accept(news.articles)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
