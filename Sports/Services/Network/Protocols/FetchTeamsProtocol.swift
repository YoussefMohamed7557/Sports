//
//  FetchTeamsProtocol.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
protocol FetchTeamsProtocol {
    static func getTeams(sportName: String ,leagueId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
}
