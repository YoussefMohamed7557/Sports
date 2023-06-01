//
//  LeagueDetailsViewModel.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
class LeagueDetailsViewModel{
    var bindUpComingListToLeagueDetailsVC :  (()->()) = {}
    var bindLatestEventListToLeagueDetailsVC :  (()->()) = {}
    var bindTeamsListToLeagueDetailsVC :  (()->()) = {}
    
    var upComingList  : [UpCommingEvent]? {
        didSet {
            bindUpComingListToLeagueDetailsVC()
        }
    }
    var latestEventsList : [LatestEvents]?{
        didSet{
            bindLatestEventListToLeagueDetailsVC()
        }
    }
    var teamsList : [Teams]?{
        didSet{
            bindTeamsListToLeagueDetailsVC()
        }
    }
    
    func getUpccoming(sportName :  String,  leagueId: Int) {
        NetworkService.getUpComingEvents(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.upComingList = result?.result
            
        })
    }
    func getLastesEvent(sportName: String, leagueId: Int){
        NetworkService.getLatestEvents(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.latestEventsList = result?.result
            
        })
    }
    func getTeams(sportName: String, leagueId: Int){
        NetworkService.getTeams(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.teamsList = result?.result
        })
    }
  
}
