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

final class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        
    }
    
    private func setupBindings() {
        viewModel.isLoading.subscribe(onNext: { (isLoading) in
            guard let isLoading = isLoading else { return }
            
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
    }

}

