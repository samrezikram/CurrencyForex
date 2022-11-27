//
//  CountryTableViewCell.swift
//  JinglePay
//
//  Created by Mohsen Moghimi on 3/24/20.
//  Copyright © 2020 Jingle Pay. All rights reserved.
//

import UIKit
import RxSwift
import FlagKit

class CountryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var vFlag: UIView! {
    didSet {
    }
  }
  @IBOutlet weak var ivFlag: UIImageView!
  @IBOutlet weak var ivCheck: UIImageView!
  @IBOutlet weak var lbTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.layer.cornerRadius = 10
    contentView.clipsToBounds = true
  }
  
  func configure(_ country: CountryItem, isPhoneCode: Bool, isSelected: Bool) {
    let code = country.alpha2Code ?? ""
    if let flag = Flag(countryCode: code) {
      self.ivFlag.image = flag.image(style: .none)
    }
    let dialCode = country.call?.code ?? ""
    let name = country.name?.common ?? ""
    let title = isPhoneCode ? "\(dialCode) \(name)" : name
    self.lbTitle.text = title
  }
}
