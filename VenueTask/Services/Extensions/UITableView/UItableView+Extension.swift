//
//  UItableView+Extension.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
}

extension NSObject: ClassNameProtocol {}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
}

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T  else {
            fatalError("Can't dequeue cell")
        }
        return cell
    }
}
