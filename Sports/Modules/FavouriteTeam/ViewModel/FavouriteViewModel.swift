//
//  FavouriteViewModel.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
class FavouriteViewModel{
    var bindfavListToFavouriteTableViewController : (()->()) = {}
    var bindTeamListToFavouriteTableViewController : (()->()) = {}
   
    var favList : [Teams]? {
        didSet {
            bindfavListToFavouriteTableViewController()
        }
    }
    var teamDetail : Teams? {
        didSet {
            bindTeamListToFavouriteTableViewController()
        }
    }
  
    func getFavouriteTeams () {
        self.favList = TeamCoreData.coreData.fetchData()
    }
    func getTeamDetails (teamId: Int) {
        NetworkService.getTeamDetails(teamId: teamId, completionHandler: { result in self.teamDetail  = result?.result[0]
        })
    }
    func deleteTeam(team: Teams?){
        TeamCoreData.coreData.deleteTeam(team: team!)
    }
    
    
   
   
    
   
}
