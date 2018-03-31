//
//  Wireframe.swift
//  Wireframes
//
//  Created by Srdan Rasic on 31/03/2018.
//  Copyright © 2018 AbsurdAbstractions. All rights reserved.
//

import Foundation
import ReactiveKit

/// Router is just a wrapper over Subject that exposes `routes` signal to the
/// object responsible to do routing, e.g. a navigation controller.
/// Object that triggers the routing calls `navigate(to:)` method.
public class Router<Routes> {

    private let _routes = SafePublishSubject<Routes>()

    /// Emit a route when requested by the view controller that is using the router.
    public var routes: SafeSignal<Routes> {
        return _routes.toSignal()
    }

    public init() {
    }

    /// Request the given route. Object (e.g. navigation controller) that is observing
    /// `routes` signal will handle the route.
    public func navigate(to route: Routes) {
        _routes.next(route)
    }
}

/// Wireframe is just an object that contains the view controller and the router.
/// It does not have any other responsibilities.
public class Wireframe<ViewController, Routes> {

    public let viewController: ViewController
    public let router: Router<Routes>

    public init(for viewController: ViewController, router: Router<Routes>) {
        self.viewController = viewController
        self.router = router
    }
}

extension Wireframe where Routes == Void {

    /// When there is no router, one can define wireframe as `Wireframe<MyViewController, Void>`
    /// and then use this initializer to create a wireframe without a router.
    public convenience init(for viewController: ViewController) {
        self.init(for: viewController, router: Router())
    }
}
