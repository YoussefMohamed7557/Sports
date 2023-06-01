//
//  FetchLatestEventsProtocol.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
protocol FetchLatestEventsProtocol {
    static func getLatestEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (LatestEventRoot?) -> Void )
}
