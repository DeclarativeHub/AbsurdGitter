//
//  GitterClient.swift
//  API
//
//  Created by Srdan Rasic on 17/02/2018.
//  Copyright © 2018 DeclarativeHub. All rights reserved.
//

import Client
import Entities
import ReactiveKit

public protocol GitterClientDelegate: class {
    func authorize<Resource>(_ request: GitterRequest<Resource>, client: GitterClient) -> Signal<GitterRequest<Resource>, ApplicationError>
}

/// A Client subclass that adds authentication layer.
open class GitterClient: LoggingClient {

    public weak var delegate: GitterClientDelegate?

    private func authorize<Resource>(_ request: GitterRequest<Resource>) -> Signal<GitterRequest<Resource>, ApplicationError> {
        guard let delegate = delegate else {
            return Signal.failed(ApplicationError("Client delegate not set."))
        }
        return delegate.authorize(request, client: self)
    }

    private func justPerform<Resource, Error>(_ request: Request<Resource, Error>) -> Signal<Resource, ApplicationError> {
        return Signal { observer in
            let task = self.perform(request) { result in
                switch result {
                case .success(let resource):
                    observer.completed(with: resource)
                case .failure(let error):
                    observer.failed(ApplicationError(error))
                }
            }
            return BlockDisposable {
                task.cancel()
            }
        }
    }

    open func perform<Resource>(_ request: GitterRequest<Resource>) -> Signal<Resource, ApplicationError> {
        switch request.authorization {
        case .none:
            return self.justPerform(request.asClientRequest)
        case .required:
            return Signal { observer in
                return self.authorize(request).flatMapLatest { request in
                    return self.justPerform(request.asClientRequest)
                }.observe(with: observer)
            }
        }
    }
}

extension Client.Error {

    var isUnauthorizedError: Bool {
        guard let code = code else { return false }
        return [401].contains(code)
    }
}

extension GitterRequest {

    public func authorized(with token: AccessToken) -> GitterRequest<Resource> {
        var copy = self
        copy.set("Bearer " + token.accessToken, forHttpHeader: "Authorization")
        return copy
    }
}
