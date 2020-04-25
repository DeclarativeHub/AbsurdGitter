//
//  RoomViewController.swift
//  Views
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import Layoutless

public class RoomViewController: UI.ViewController, UICollectionViewDelegateFlowLayout {

    public let messagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .styled(with: Stylesheet.collectionView)

    public override func setup() {
        messagesCollectionView.delegate = self
    }

    // Using Layoutless to declaratively define layout.
    public override var subviewsLayout: AnyLayout {
        return messagesCollectionView.fillingParent()
    }

    // MARK: UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}

extension RoomViewController {

    /// Layoutless makes view classes trivial so it's perfectly fine to define then in the view controller extensions.
    public class MessageCell: UI.CollectionViewCell {

        public let userNameLabel = UI.Label(style: Stylesheet.MessageCell.userName)
        public let bodyLabel = UI.Label(style: Stylesheet.MessageCell.body)

        public override func setup() {
            Stylesheet.MessageCell.contentView.apply(to: contentView)
        }

        // Using Layoutless to declaratively define layout.
        public override var subviewsLayout: AnyLayout {
            return stack(.vertical, spacing: 4)(
                userNameLabel,
                bodyLabel
            ).fillingParent(insets: (left: 20, right: 20, top: 10, bottom: 10))
        }
    }
}

extension RoomViewController {

    /// We can define a stylesheet for the view controller and its subviews in the view controller extension.
    public enum Stylesheet {

        public static let collectionView = Style<UICollectionView> {
            $0.backgroundColor = UIColor(white: 0.99, alpha: 1)
            guard let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.minimumLineSpacing = 0
        }

        public enum MessageCell {

            public static let contentView = Style<UIView> {
                $0.backgroundColor = .white
            }

            public static let userName = Style<UI.Label> {
                $0.font = .systemFont(ofSize: 14, weight: .bold)
                $0.textColor = .purple
            }

            public static let body = Style<UI.Label> {
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = .black
                $0.numberOfLines = 0
                $0.preferredMaxLayoutWidth = 300
            }
        }
    }
}

