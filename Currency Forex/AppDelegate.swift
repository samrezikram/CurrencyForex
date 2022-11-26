//
//  AppDelegate.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//

import UIKit

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

}

extension AppDelegate {
  func start(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
   
    self.window.backgroundColor = UIColor.white
    
    appCoordinator.strongRouter.setRoot(for: self.window)
    appCoordinator.rootViewController.navigationController?.navigationBar.isHidden = true
  }
}

