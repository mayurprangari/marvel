//
//  AppDelegate.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var activityIndicator =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var arrLoader = NSMutableArray()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func showToast(message:String)
    {
        ToastManager.shared.style.messageFont = UIFont.systemFont(ofSize: 18)
        UIApplication.shared.windows.first { $0.isKeyWindow }?.makeToast(message)
    }
    
    func showSoftActivityIndicator(controller:UIViewController? = nil)
    {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.midX - 10, y: UIScreen.main.bounds.midY - 10, width: 50, height: 50))
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        arrLoader.add(activityIndicator)
        controller!.view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

