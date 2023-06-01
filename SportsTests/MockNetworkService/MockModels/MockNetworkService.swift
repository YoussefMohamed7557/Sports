//
//  MockNetworkService.swift
//  SportsTests
//
//  Created by Youssef on 30/05/2023.
//

import Foundation
@testable import Sports
class MockNetworkService : NetworkServicesProtocol{
    static func getLeague(sportName: String, completionHandler: @escaping (Sports.LeagueRoot?) -> Void) {
        let data = Data(MockLeagueResponce.leagueResponce.utf8)
        do{
            let result = try JSONDecoder().decode(LeagueRoot.self, from: data)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getUpComingEvents(sportName: String, leagueId: Int, completionHandler: @escaping (Sports.UpComingRoot?) -> Void) {
        let data = Data(MockUpComingEventsResponce.upComingResponce.utf8)
        do{
            let result = try JSONDecoder().decode(UpComingRoot.self, from: data)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getLatestEvents(sportName: String, leagueId: Int, completionHandler: @escaping (Sports.LatestEventRoot?) -> Void) {
        let data = Data(MockLatestEventResponcce.latestResponce.utf8)
        do{
            let result = try JSONDecoder().decode(LatestEventRoot.self, from: data)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getTeams(sportName: String, leagueId: Int, completionHandler: @escaping (Sports.TeamsRoot?) -> Void) {
        let data = Data(MockTeamResponce.teamResponce.utf8)
        do{
            let result = try JSONDecoder().decode(TeamsRoot.self, from: data)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func getTeamDetails(teamId: Int, completionHandler: @escaping (Sports.TeamsRoot?) -> Void) {
        let data = Data(MockTeamResponce.teamResponce.utf8)
        do{
            let result = try JSONDecoder().decode(TeamsRoot.self, from: data)
            completionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    
}
