//
//  LeagueViewModel.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
class LeagueViewModel {
    var bindListToLeagueTableViewController : (()->()) = {}
   
    var leagueList : [League]? {
        didSet {
            bindListToLeagueTableViewController()
        }
    }
    
    func getLeagues (sportName : String) {
        NetworkService.getLeague(sportName: sportName, completionHandler: {
            result in self.leagueList = result?.result
        })
    }
}
