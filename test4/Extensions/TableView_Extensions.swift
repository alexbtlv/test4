//
//  TableView_Extensions.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//
import UIKit

protocol CellInterface {
    
    static var id: String { get }
    static var cellNib: UINib { get }
    
}

extension CellInterface {
    
    static var id: String {
        return String(describing: Self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
}

extension UITableView {
    
    func register(cellInterface type: CellInterface.Type) {
        self.register(type.cellNib, forCellReuseIdentifier: type.id)
    }
    
    func dequeueReusableCell<T: CellInterface>() -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.id) as? T else {
            fatalError("Cell is not of kind \(T.id)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: CellInterface>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.id, for: indexPath) as? T else {
            fatalError("Cell is not of kind \(T.id)")
        }
        return cell
    }
}
