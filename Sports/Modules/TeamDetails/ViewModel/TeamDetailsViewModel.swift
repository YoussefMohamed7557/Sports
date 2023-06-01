//
//  TeamDetailsViewModel.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
class TeamDetailsViewModel{
  
    func saveToCoreData(team:Teams?){
        TeamCoreData.coreData.insertTeam(team: team!)
    }
    
    func deleteFromCoreData(team: Teams?){
        TeamCoreData.coreData.deleteTeam(team: team!)
    }
    
    func isFavouriteTeam(team: Teams?) -> Bool {
        return TeamCoreData.coreData.isTeamFavourite(team: team!)
    }
}
