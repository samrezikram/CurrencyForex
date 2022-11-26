//
//  BestRatesVC.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//

import UIKit
import RxSwift
import FlagKit
import RxCocoa
import ZVProgressHUD

class BestRatesVC: UIViewController {
  @IBOutlet private weak var lbLastUpdate: UILabel!
  @IBOutlet private weak var lbCurrency: UILabel!
  @IBOutlet private weak var ivAedFlag: UIImageView! {
    didSet {
      ivAedFlag.image = Flag(countryCode: "AE")?.image(style: .none)
    }
  }
  @IBOutlet private weak var ivFlag: UIImageView!
  
  @IBOutlet private weak var tfAedAmount: UITextField!
  @IBOutlet private weak var tfAmount: UITextField!
  @IBOutlet weak private var vCurrency: UIView!
 
  
  private let disposeBag = DisposeBag()
  
  var viewModel: BestRatesVM!

  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
}

extension BestRatesVC: BindableType {
  func bindViewModel() {

    viewModel.output.isLoading.asObservable()
      .bind(onNext: { isLoading in
        if isLoading { ZVProgressHUD.show() } else { ZVProgressHUD.dismiss() }
      }).disposed(by: disposeBag)
    viewModel.output.lastUpdatedTime
      .bind(to: lbLastUpdate.rx.text)
      .disposed(by: disposeBag)
    tfAedAmount.rx.controlEvent(.editingChanged)
      .withLatestFrom(tfAedAmount.rx.text.orEmpty)
      .debounce(.milliseconds(Constants.APP.debounceInputRquestInterval), scheduler: MainScheduler.instance)
      .subscribe(onNext: { text in
        self.tfAedAmount.resignFirstResponder()
      }).disposed(by: disposeBag)
    tfAmount.rx.controlEvent(.editingChanged)
      .withLatestFrom(tfAmount.rx.text.orEmpty)
      .debounce(.milliseconds(Constants.APP.debounceInputRquestInterval), scheduler: MainScheduler.instance)
      .subscribe(onNext: { text in
        self.tfAmount.resignFirstResponder()
      }).disposed(by: disposeBag)
  }
}



