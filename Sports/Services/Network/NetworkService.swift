//
//  NetworkService.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//
// my key = 70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c
import Foundation
class NetworkService : NetworkServicesProtocol {
    
    static func getLeague(sportName: String, completionHandler: @escaping (LeagueRoot?) -> Void ) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(LeagueRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription )
                completionHandler(nil)
            }
        
        }
        task.resume()
    }
    
    static func getUpComingEvents(sportName: String, leagueId: Int, completionHandler: @escaping (UpComingRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2022-05-09&to=2024-02-09&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(UpComingRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription , newUrl)
                completionHandler(nil)
                print(newUrl)
            }
            
        }
        task.resume()
    }
    
    static func getLatestEvents(sportName: String, leagueId: Int, completionHandler: @escaping (LatestEventRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2022-05-09&to=2024-02-09&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(LatestEventRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func getTeams(sportName: String, leagueId: Int, completionHandler: @escaping (TeamsRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(TeamsRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsRoot?) -> Void ){
        let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamId)&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(TeamsRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
}
