//
//  AppDelegate.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//

import UIKit
import ZVProgressHUD
import AlamofireNetworkActivityLogger
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let appCoordinator = AppCoordinator()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  let window: UIWindow! = UIWindow()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    start(application: application, launchOptions: launchOptions)
    return true
  }
  
  /// Configure progress HUD
  private func configureProgressHUD() {
    ZVProgressHUD.setMaskType(.black)
    ZVProgressHUD.setDisplayStyle(.custom((backgroundColor: #colorLiteral(red: 0.3019607843, green: 0.4823529412, blue: 0.968627451, alpha: 1), foregroundColor: .white)))
    ZVProgressHUD.setAnimationType(.flat)
  }
}

extension AppDelegate {
  func start(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
   
    self.window.backgroundColor = UIColor.white
    
    self.configureProgressHUD()
    
    /// Configure AppHelper
    AppHelper.shared.initData()
    
    NetworkActivityLogger.shared.startLogging()
    NetworkActivityLogger.shared.level = .debug
    
    appCoordinator.strongRouter.setRoot(for: self.window)
    appCoordinator.rootViewController.navigationController?.navigationBar.isHidden = true
    

  }
}

