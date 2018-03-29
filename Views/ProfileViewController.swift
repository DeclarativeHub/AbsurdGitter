//
//  ProfileViewController.swift
//  Views
//
//  Created by Srdan Rasic on 29/03/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import Layoutless

public class ProfileViewController: ViewController {

    public let nameLabel = Label(style: Stylesheet.name)
    public let usernameLabel = Label(style: Stylesheet.username)
    public let logoutButton = Button(type: .system)

    public override func setup() {
        tabBarItem.image = #imageLiteral(resourceName: "avatar")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        Stylesheet.view.apply(to: view)
    }

    // Using Layoutless to declaratively define layout.
    public override var subviewsLayout: AnyLayout {
        return stack(.vertical, spacing: 10)(
            nameLabel,
            usernameLabel,
            verticalSpacing(20),
            logoutButton
        ).centeringInParent(relativeToSafeArea: true)
    }
}

extension ProfileViewController {

    /// We can define a stylesheet for the view controller and its subviews in the view controller extension.
    public enum Stylesheet {

        public static let view = Style<UIView> {
            $0.backgroundColor = .white
        }

        public static let name = Style<Label> {
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            $0.textAlignment = .center
        }

        public static let username = Style<Label> {
            $0.font = UIFont.systemFont(ofSize: 19, weight: .regular)
            $0.textAlignment = .center
        }
    }
}
