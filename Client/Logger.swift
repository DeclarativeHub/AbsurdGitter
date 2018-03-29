//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Srdan Rasic (@srdanrasic)
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

public protocol Logger {
    func error(_ message: Any)
    func warning(_ message: Any)
    func info(_ message: Any)
    func debug(_ message: Any)
}

public class SimpleLogger: Logger {

    public enum Level: Int {
        case none = 0
        case error = 1
        case warning = 2
        case info = 3
        case debug = 4
    }

    public let prefix: String

    public var level: Level = .debug

    public func error(_ message: Any) {
        guard level.rawValue >= Level.error.rawValue else { return }
        print("[\(prefix)] 💥 \(message)")
    }

    public func warning(_ message: Any) {
        guard level.rawValue >= Level.warning.rawValue else { return }
        print("[\(prefix)] ⚠️ \(message)")
    }

    public func info(_ message: Any) {
        guard level.rawValue >= Level.info.rawValue else { return }
        print("[\(prefix)] 💚 \(message)")
    }

    public func debug(_ message: Any) {
        guard level.rawValue >= Level.debug.rawValue else { return }
        print("[\(prefix)] 🐞 \(message)")
    }

    public init(prefix: String) {
        self.prefix = prefix
    }
}

public var log: Logger = SimpleLogger(prefix: "Client")
