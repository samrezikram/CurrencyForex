//
//  BestRatesVMImpl.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//


import Action
import RxSwift
import RxCocoa
import XCoordinator

class BestRatesVMImpl: BestRatesVM, BestRatesVMInput, BestRatesVMOutput {
    
  // MARK: - Outputs
  var isLoading = BehaviorRelay<Bool>(value: false)
  var isError = BehaviorRelay<Bool>(value: false)
  var sourceAmount = BehaviorRelay<String?>(value: "")
  var targetAmount = BehaviorRelay<String?>(value: "")
  var lastUpdatedTime = BehaviorRelay<String?>( value: nil )
  var currencyTitle = BehaviorRelay<String?>( value: nil )
  var currencyCode = BehaviorRelay<String?>( value: nil )
  var sourceCountry = BehaviorRelay<CountryItem>( value: CountryItem(name: CountryNameItem(common: "United Arab Emirates", official: "United Arab Emirates"), ccn3Code: "784", alpha2Code: "AE", alpha3Code: "UAE", flag: "🇦🇪", currency: CountryCurrencyItem(code: "AED")) )
  var destinationCountry = BehaviorRelay<CountryItem>( value: CountryItem(name: CountryNameItem(common: "Pakistan", official: "Islamic Republic of Pakistan"), ccn3Code: "586", alpha2Code: "PK", alpha3Code: "PAK", flag: "🇵🇰", currency: CountryCurrencyItem(code: "PKR")) )

  var remittance​Countries = BehaviorRelay<[CountryNameItem]?>( value: nil )

  // MARK: - Inputs
  private(set) lazy var detailTrigger: AnyObserver<Void> = detailAction.inputs
  private(set) lazy var sourceCurrencyTrigger: AnyObserver<Void> = sourceCurrencyAction.inputs
  private(set) lazy var destinationCurrencyTrigger: AnyObserver<Void> = destinationCurrencyAction.inputs

  private lazy var detailAction = CocoaAction { [unowned self] in
//    self.router.trigger(.detail)
    return Observable.empty()
  }
  
  private lazy var sourceCurrencyAction = CocoaAction { [unowned self] in
//    self.router.trigger(.detail)
    return Observable.empty()
  }
  
  private lazy var destinationCurrencyAction = CocoaAction { [unowned self] in
//    self.router.trigger(.detail)
    return Observable.empty()
  }
  
  
  // MARK: - Private
  private let router: UnownedRouter<AppRoute>
  private let paymentService: PaymentService
  private var isFirstLaunch: Bool = false

  // MARK: - Init
  init(router: UnownedRouter<AppRoute>, paymentService: PaymentService, isFirstLaunch: Bool) {
    self.router = router
    self.paymentService = paymentService
    self.isFirstLaunch = isFirstLaunch
  }
  
}

