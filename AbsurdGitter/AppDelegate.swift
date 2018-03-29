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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Create main window wireframe with the session manager. Consult MainWindow.swift.
        let wireframe = UIWindow.makeWireframe(sessionManager)

        window = wireframe.window
        window?.makeKeyAndVisible()

        return true
    }

    /// Observe url scheme deep link - contains OAuth code when user logs in.
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return sessionManager.handleOpenUrl(url)
    }
}
