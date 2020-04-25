//
//  RoomListViewController.swift
//  Views
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import Layoutless

public class RoomListViewController: UI.ViewController, UICollectionViewDelegateFlowLayout {

    public let roomsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .styled(with: Stylesheet.collectionView)

    public override func setup() {
        tabBarItem.image = #imageLiteral(resourceName: "chat")
        roomsCollectionView.delegate = self
    }

    // Using Layoutless to declaratively define layout.
    public override var subviewsLayout: AnyLayout {
        return roomsCollectionView.fillingParent()
    }

    // MARK: UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: 100)
    }
}

extension RoomListViewController {

    /// Layoutless makes view classes trivial so it's perfectly fine to define then in the view controller extensions.
    public class RoomCell: UI.CollectionViewCell {

        public let nameLabel = UI.Label(style: Stylesheet.RoomCell.name)

        public override func setup() {
            Stylesheet.RoomCell.contentView.apply(to: contentView)
        }

        // Using Layoutless to declaratively define layout.
        public override var subviewsLayout: AnyLayout {
            return nameLabel.fillingParent(insets: 20)
        }
    }
}

extension RoomListViewController {

    /// We can define a stylesheet for the view controller and its subviews in the view controller extension.
    public enum Stylesheet {

        public static let collectionView = Style<UICollectionView> {
            $0.backgroundColor = UIColor(white: 0.99, alpha: 1)
            guard let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.minimumLineSpacing = 15
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }

        public enum RoomCell {

            public static let contentView = Style<UIView> {
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 8
                $0.layer.shadowOpacity = 0.05
                $0.layer.shadowColor = UIColor.black.cgColor
                $0.layer.shadowOffset = .zero
                $0.layer.shadowRadius = 10
            }

            public static let name = Style<UI.Label> {
                $0.font = .systemFont(ofSize: 18, weight: .black)
                $0.textColor = .purple
            }
        }
    }
}
