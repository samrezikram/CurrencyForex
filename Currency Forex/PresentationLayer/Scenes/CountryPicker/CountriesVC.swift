//
//  CountriesVC.swift
//  JinglePay
//
//  Created by NDN on 22.09.2021.
//  Copyright © 2021 Jingle Pay. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol CountriesVCDelegate: AnyObject {
  func countrySelected(_ country: CountryItem)
}

class CountriesVC: UIViewController {
  
  var caption: String?
  var selectedCode: String?
  weak var delegate: CountriesVCDelegate?
  var isPhoneCode: Bool = true
  
 
  
  @IBOutlet weak var lbTitle: UILabel! {
    didSet {
      lbTitle.text = "Select Countries"
    }
  }
    
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.backgroundColor = .white
      tableView.separatorStyle = .singleLine
      tableView.tableFooterView = UIView()
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(CountryTableViewCell.self)
      tableView.reloadData()
    }
  }
  @IBOutlet weak var tableViewHeiht: NSLayoutConstraint!
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    if UIDevice.current.orientation.isLandscape {
      self.tableViewHeiht.constant = UIScreen.main.bounds.height - 100
    } else  {
      self.tableViewHeiht.constant = 465
    }
  }
  
  private let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.lbTitle.text = caption
  }
}

extension CountriesVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return AppHelper.shared.countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CountryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    let country = AppHelper.shared.countries[indexPath.row]
    let code =  country.ccn3Code ?? ""
    cell.layer.cornerRadius = 10
    cell.clipsToBounds = true
    let isSelected = code == selectedCode
    cell.configure(country, isPhoneCode: isPhoneCode, isSelected: isSelected)
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.clear
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let country = AppHelper.shared.countries[indexPath.row]
    let cell: CountryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.configure(country, isPhoneCode: isPhoneCode, isSelected: true)
    delegate?.countrySelected(country)
  }
}
