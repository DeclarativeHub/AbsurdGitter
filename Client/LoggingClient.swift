//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// A Client subclass that adds logging layer.
open class LoggingClient: Client {

    open override func perform<Resource, Error>(_ request: Request<Resource, Error>, completion: @escaping (Result<Resource, Client.Error>) -> Void) -> URLSessionTask {
        let requestDescription: String
        if let parameters = request.parameters {
            requestDescription = "\(request.method.rawValue) \(request.path); \(String(describing: parameters))"
        } else {
            requestDescription = "\(request.method.rawValue) \(request.path)"
        }
        log.info("Sent request: " + requestDescription)

        return super.perform(request, completion: { (result) in

            switch result {
            case .success(let value):
                log.info("Received response for: " + requestDescription)
                log.debug("Parsed response data: \(value)")
            case .failure(let error):
                log.error("Request failed: " + requestDescription + "\nWith error: " + error.localizedDescription)
            }

            completion(result)
        })
    }
}
