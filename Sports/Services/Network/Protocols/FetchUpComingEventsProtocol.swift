//
//  FetchUpComingEventsProtocol.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
protocol FetchUpComingEventsProtocol {
    static func getUpComingEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (UpComingRoot?) -> Void )
}
