//
//  MainViewModel.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Moya
import RxCocoa
import RxSwift

final class MainViewModel {
    
    // MARK: Private properties
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    private var articles = [Article]() {
        didSet {
            setupSections()
        }
    }
    
    // MARK: Public properties
    let currentPage = BehaviorRelay(value: 1)
    let isLoading: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    let sections: BehaviorRelay<[MainSectionModel]> = BehaviorRelay(value: [])
    let searchQuery: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    init() {
        self.provider = MoyaProvider<APIProvider>()
        
        searchQuery.asDriver().debounce(.seconds(1)).drive(onNext: { [weak self] (searchText) in
            guard let searchText = searchText, !searchText.isEmpty else { return }
            self?.performSearchQuery()
        }).disposed(by: disposeBag)
        
        getNews()
    }
    
    private func getNews() {
        isLoading.accept(true)
        provider.request(.getNews(page: currentPage.value)) { [weak self] (result) in
            self?.isLoading.accept(false)
            switch result {
            case .success(let response):
                if let news = try? JSONDecoder().decode(NewsResponseModel.self, from: response.data) {
                    self?.articles = news.articles
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func performSearchQuery() {
        guard let query = searchQuery.value else { return }
        self.isLoading.accept(true)
        provider.request(.searchNews(query: query, page: currentPage.value)) { [weak self] (result) in
            self?.isLoading.accept(false)
            switch result {
            case .success(let response):
                if let news = try? JSONDecoder().decode(NewsResponseModel.self, from: response.data) {
                    self?.articles = news.articles
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupSections() {
        let items = articles.map { MainSectionItem.article(cellViewModel: ArticleCellViewModel(article: $0)) }
        sections.accept([.main(items: items)])
    }
}
