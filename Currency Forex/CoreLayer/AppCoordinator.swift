
import XCoordinator
import UIKit

/// Main application route
/// Using for main application flow
enum AppRoute: Route {
  
  /// Best Rates scene
  case bestRates
    
  /// Navigate back to previous scene
  case back
  
}

/// Main application coordinator
class AppCoordinator: NavigationCoordinator<AppRoute> {
  
  let paymentService = PaymentServiceImpl()

  init() {
    let route: AppRoute =  .bestRates
    
    super.init(initialRoute: route)
    self.rootViewController.navigationBar.isHidden = true
  }

  /// This method prepares transitions for routes.
  ///
  /// - Parameter route: The triggered route for which a transition is to be prepared.
  /// - Returns: The prepared transition.
  override func prepareTransition(for route: AppRoute) -> NavigationTransition {
    switch route {
    case .bestRates:
      let viewController = BestRatesVC.instantiateFromNib()
      let viewModel = BestRatesVMImpl(router: unownedRouter, paymentService: self.paymentService, isFirstLaunch: true)
      viewController.bind(to: viewModel)
      return .push(viewController)

    case .back:
      return .dismiss()

    }
  }
}
