//
//  NetworkServicesProtocol.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
protocol NetworkServicesProtocol : FetchLeaguesProtocol, FetchUpComingEventsProtocol, FetchLatestEventsProtocol,
                                   FetchTeamsProtocol {
    static func getLeague(sportName: String , completionHandler: @escaping (LeagueRoot?) -> Void )
    
    static func getUpComingEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (UpComingRoot?) -> Void )
    
    static func getLatestEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (LatestEventRoot?) -> Void )
    
    static func getTeams(sportName: String ,leagueId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
}
