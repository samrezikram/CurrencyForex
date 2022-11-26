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
  
  // MARK: - Inputs
  private(set) lazy var detailTrigger: AnyObserver<Void> = detailAction.inputs
  private lazy var detailAction = CocoaAction { [unowned self] in
//    self.router.trigger(.detail)
    return Observable.empty()
  }
  
  // MARK: - Private
  private let router: UnownedRouter<AppRoute>
  private var isFirstLaunch: Bool = false

  // MARK: - Init
  
  init(router: UnownedRouter<AppRoute>, isFirstLaunch: Bool) {
    self.router = router
    self.isFirstLaunch = isFirstLaunch
  }
  
}

