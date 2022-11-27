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
import RxSwift
import RxGesture
import ZVProgressHUD

class BestRatesVC: UIViewController {
  @IBOutlet private weak var lbLastUpdate: UILabel!
  
  @IBOutlet private weak var sourceAeFlag: UIImageView! {
    didSet {
      sourceAeFlag.image = Flag(countryCode: "AE")?.image(style: .none)
    }
  }
  @IBOutlet private weak var lbSourceCurrency: UILabel! {
    didSet { }
  }

  @IBOutlet private weak var tfAedAmount: UITextField!
  @IBOutlet private weak var vSourceCurrency: UIView!

  
  @IBOutlet private weak var destinationPKFlag: UIImageView! {
    didSet {
      destinationPKFlag.image = Flag(countryCode: "PK")?.image(style: .none)
    }
  }
  @IBOutlet private weak var lbDestinationCurrency: UILabel!
  @IBOutlet private weak var tfDestinationPkAmount: UITextField!
  @IBOutlet weak private var vDestinationCurrency: UIView!

   
  @IBOutlet weak var swapCurrencies: UIButton! {
    didSet {
      swapCurrencies.addTarget(self, action: #selector(swapCurrenciesAction), for: .touchUpInside)
    }
  }
  
  @IBOutlet weak var detail: UIButton! {
    didSet {
      detail.addTarget(self, action: #selector(detailRatesAction), for: .touchUpInside)
    }
  }
  
  @IBOutlet weak var detailHeightContraint: NSLayoutConstraint!
  private var bottomSheetController: JPBottomSheetVC?

  private let disposeBag = DisposeBag()
  var viewModel: BestRatesVM!
  
  /// Private
  var isSourceSelection: Bool = true

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    if UIDevice.current.orientation.isLandscape {
      detailHeightContraint.constant = 10
    } else  {
      detailHeightContraint.constant = 50
    }
  }
  
  private func showCountryPicker() {
    let countriesVC = CountriesVC.instantiateFromNib()
    bottomSheetController = JPBottomSheetVC(contentViewController: countriesVC)
    countriesVC.caption = "Select Country"
    countriesVC.isPhoneCode = false
    countriesVC.delegate = self
    present(bottomSheetController!, animated: true)
  }
  
  @objc private func swapCurrenciesAction() {
    let destinationCountry = self.viewModel.output.destinationCountry.value
    self.viewModel.output.destinationCountry.accept(self.viewModel.output.sourceCountry.value)
    self.viewModel.output.sourceCountry.accept(destinationCountry)
  }
  
  @objc private func detailRatesAction() {
    print("detailRatesAction")
    self.viewModel.input.fetchRemittance​Countries()
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
    
    
    vSourceCurrency.rx.tapGesture()
      .when(.recognized)
      .map({ _ in return () })
      .asObservable()
      .bind(onNext: { _ in
        self.isSourceSelection = true
        self.showCountryPicker()
      })
      .disposed(by: disposeBag)
    
    vDestinationCurrency.rx.tapGesture()
      .when(.recognized)
      .map({ _ in return () })
      .asObservable()
      .bind(onNext: { _ in
        self.isSourceSelection = false
        self.showCountryPicker()
      })
      .disposed(by: disposeBag)
    
    viewModel.output.sourceCountry.asObservable()
      .bind(onNext: { sourceCountry in
        let countryCode = sourceCountry.alpha2Code ?? ""
        self.sourceAeFlag.image = Flag(countryCode: countryCode)?.image(style: .none)
        self.lbSourceCurrency.text = sourceCountry.currency?.code ?? ""
      }).disposed(by: disposeBag)
    
    viewModel.output.destinationCountry.asObservable()
      .bind(onNext: { destinationCountry in
        let countryCode = destinationCountry.alpha2Code ?? ""
        self.destinationPKFlag.image = Flag(countryCode: countryCode)?.image(style: .none)
        self.lbDestinationCurrency.text = destinationCountry.currency?.code ?? ""
      }).disposed(by: disposeBag)

  }
}

extension BestRatesVC: CountriesVCDelegate {
  func countrySelected(_ country: CountryItem) {
    bottomSheetController?.dismiss(animated: true, completion: nil)
    if self.isSourceSelection {
      self.viewModel.output.sourceCountry.accept(country)
    } else {
      self.viewModel.output.destinationCountry.accept(country)
    }
  }
}




