//
//  LoginView.swift
//  Views
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import Layoutless

public class LoginViewController: UI.ViewController {

    public let loginButton = UI.Button(type: .system).styled(with: Stylesheet.loginButton)

    public override func viewDidLoad() {
        super.viewDidLoad()
        Stylesheet.view.apply(to: view)
    }

    // Using Layoutless to declaratively define layout.
    public override var subviewsLayout: AnyLayout {
        return loginButton.centeringInParent()
    }
}

extension LoginViewController {

    /// We can define a stylesheet for the view controller and its subviews in the view controller extension.
    public enum Stylesheet {

        public static let view = Style<UIView> {
            $0.backgroundColor = .white
        }

        public static let loginButton = Style<UI.Button> {
            $0.setTitleColor(.purple, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20)
        }
    }
}
