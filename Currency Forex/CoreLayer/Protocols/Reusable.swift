//
//  Reusable.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import UIKit

protocol Reusable {
  static var reuseID: String {get}
}

extension Reusable {
  static var reuseID: String {
    return String(describing: self)
  }
}

// MARK: - View
extension UIView: Reusable {
  class func instance() -> Self {
    guard let view = Bundle.main.loadNibNamed(reuseID, owner: self, options: nil)?.first as? Self else {
      fatalError("Unable to instantiate view: \(self)")
    }
    
    return view
  }
}

// MARK: - View Controller

extension UIViewController: Reusable {
  class func instance() -> Self {
    let storyboard = UIStoryboard(name: reuseID, bundle: nil)
    return storyboard.instantiateViewController()
  }
}

extension UIStoryboard {
  func instantiateViewController<T: UIViewController>() -> T {
    guard let viewController = self.instantiateViewController(withIdentifier: T.reuseID) as? T else {
      fatalError("Unable to instantiate view controller: \(T.self)")
    }
    return viewController
  }
}

// MARK: - Table View
extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) {
    let nib = UINib(nibName: T.reuseID, bundle: nil)
    self.register(nib, forCellReuseIdentifier: T.reuseID)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
      fatalError("Unable to dequeue reusable table view cell: \(T.self)")
    }
    return cell
  }
}
