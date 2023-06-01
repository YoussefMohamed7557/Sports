//
//  fetchLeaguesProtocol.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
protocol FetchLeaguesProtocol {
    static func getLeague(sportName: String , completionHandler: @escaping (LeagueRoot?) -> Void )
}
