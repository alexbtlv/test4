//
//  ViewController.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD
import RxSwift
import RxCocoa
import RxDataSources

final class MainViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellInterface: ArticleTableViewCell.self)
    }
    
    private func setupBindings() {
        viewModel.sections
        .bind(to: tableView.rx.items(dataSource: dataSource()))
        .disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe(onNext: { (isLoading) in
            guard let isLoading = isLoading else { return }
            
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
        
        searchBar.rx.text.subscribe(onNext: { [weak self] (text) in
            self?.viewModel.searchQuery.accept(text)
        }).disposed(by: disposeBag)
    }
    
    private func dataSource() -> RxTableViewSectionedReloadDataSource<MainSectionModel> {
        return RxTableViewSectionedReloadDataSource<MainSectionModel>(configureCell: { (_, tv, indexPath, item) -> UITableViewCell in
            switch item {
            case .article(let cellViewModel):
                let cell: ArticleTableViewCell = tv.dequeueReusableCell(for: indexPath)
                cell.configure(with: cellViewModel)
                return cell
            }
        })
    }
}
