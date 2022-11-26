//
//  BestRatesVM.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//

import Action
import RxSwift
import RxCocoa

protocol BestRatesVMInput {
  var detailTrigger: AnyObserver<Void> { get }
}

protocol BestRatesVMOutput {
  var isLoading: BehaviorRelay<Bool> { get }
  var lastUpdatedTime: BehaviorRelay<String?> { get }
  var currencyTitle: BehaviorRelay<String?> { get }
  var currencyCode: BehaviorRelay<String?> { get }
  var sourceAmount: BehaviorRelay<String?> { get }
  var targetAmount: BehaviorRelay<String?> { get }
  var isError: BehaviorRelay<Bool> { get }

}

protocol BestRatesVM {
  var input: BestRatesVMInput { get }
  var output: BestRatesVMOutput { get }

}

extension BestRatesVM where Self: BestRatesVMInput & BestRatesVMOutput {
  var input: BestRatesVMInput { return self }
  var output: BestRatesVMOutput { return self }
}
