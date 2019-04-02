//
//  AppDelegate.swift
//  AbsurdGitter
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import Binders
import Services

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// SessionManager manages current user session.
    let sessionManager = SessionManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.makeMainWindow(sessionManager)
        window?.makeKeyAndVisible()

        return true
    }

    /// Observe url scheme deep link - contains OAuth code when user logs in.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return sessionManager.handleOpenUrl(url)
    }
}
