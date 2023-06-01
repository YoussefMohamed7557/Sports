//
//  InternetChecker.swift
//  Sports
//
//  Created by Youssef on 25/05/2023.
//

import Foundation
import Reachability
class InternetCheker{
    static var reachabilityInstance: Reachability?
    static func isInternetAvailable() -> Bool {
        let reachability = try? reachabilityInstance ?? Reachability()
            return reachability?.connection != .unavailable
    }
}
