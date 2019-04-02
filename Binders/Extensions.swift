//
//  Extensions.swift
//  Binders
//
//  Created by Srdan Rasic on 18/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import UIKit
import ReactiveKit
import Bond
import Views
import Layoutless
import Services

func itemAtIndex<C: Collection>(_ index: C.Index, from collection: C) -> C.Element {
    return collection[index]
}

func itemAtIndexPath<C: Collection>(_ index: IndexPath, from collection: C) -> C.Element where C.Index == Int {
    return collection[index.row]
}

extension UIView {

    private static let loadingIndicatorTag = 10001

    private var loadingIndicator: UIActivityIndicatorView? {
        return viewWithTag(UIView.loadingIndicatorTag) as? UIActivityIndicatorView
    }

    /// Adds UIActivityIndicatorView as a subview when true.
    var isLoadingIndicatorVisible: Bool {
        get {
            return loadingIndicator != nil
        }
        set {
            if newValue {
                guard loadingIndicator == nil else { return }
                let indicator = UIActivityIndicatorView(style: .gray)
                indicator.tag = UIView.loadingIndicatorTag
                indicator
                    .sizing(toWidth: 44, height: 44)
                    .centeringInParent(xOffset: 0, yOffset: 0, relativeToSafeArea: true)
                    .layout(in: self)
                indicator.startAnimating()
            } else {
                loadingIndicator?.removeFromSuperview()
            }
        }
    }
}

// Makes UIViewController a LoadingStateListener. That means that we can pass an instance of UIViewController
// to `consumeLoadingState` operator of a LoadingSignal to convert it into regular SafeSignal.
// Loading state is "consumed" by the view controller by displaying the loading indicator when needed.
extension UIViewController: LoadingStateListener {

    public func setLoadingState<LoadingValue, LoadingError>(_ state: ObservedLoadingState<LoadingValue, LoadingError>) {
        switch state {
        case .loading:
            view.isLoadingIndicatorVisible = true
        case .reloading:
            view.isLoadingIndicatorVisible = true
        case .loaded:
            view.isLoadingIndicatorVisible = false
        case .failed(let error):
            view.isLoadingIndicatorVisible = false
            displayError(error)
        }
    }

    public func displayError(_ error: Error) {
        // Advice: Present error popup or error overlay view instead
        print(error)
    }
}
