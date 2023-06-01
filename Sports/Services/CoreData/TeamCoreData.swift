//
//  TeamCoreData.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
import UIKit
import CoreData
class TeamCoreData{
    static var coreData = TeamCoreData()
    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    let entity: NSEntityDescription?
    private init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
         managedContext = appDelegate?.persistentContainer.viewContext
         entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext!)
    }
    func insertTeam(team:Teams){
        let teamEntity = NSManagedObject(entity: entity!, insertInto: managedContext!)
        teamEntity.setValue(team.team_key, forKey: "teamKey")
        teamEntity.setValue(team.team_name, forKey: "teamName")
        teamEntity.setValue(team.team_logo, forKey: "teamLogo")
        teamEntity.setValue(true, forKey: "isTeamFav")
        do{
            try managedContext?.save()
        }catch let errror as NSError{
            print(errror)
        }
    }
    func fetchData() -> [Teams]? {
        var teamsList  =  [Teams]()
        var teamsObjects : [NSManagedObject]?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do{
            teamsObjects = try managedContext?.fetch(fetchRequest)
            print("teamObject \(teamsObjects!.count)")
            for team in teamsObjects!{
                let team = Teams(team_key: team.value(forKey: "teamKey") as? Int,
                                 team_name: team.value(forKey: "teamName") as? String,
                                 team_logo: team.value(forKey: "teamLogo") as? String)
                teamsList.append(team)
            }
        }catch let errror as NSError{
            print(errror)
        }
        return teamsList
    }
    func deleteTeam(team:Teams){
        var teamObjects : [NSManagedObject]?
        let fetchReq=NSFetchRequest<NSManagedObject>(entityName: "Team")
        let predicate=NSPredicate(format: "teamKey==%i", team.team_key!)
        fetchReq.predicate=predicate
        do{
            teamObjects = try managedContext?.fetch(fetchReq)
            managedContext?.delete(teamObjects![0])
            try managedContext?.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    func isTeamFavourite(team:Teams) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        fetchRequest.predicate = NSPredicate(format: "teamKey == %i", team.team_key!)
           do {
               let teams = try managedContext!.fetch(fetchRequest) as! [NSManagedObject]
               if let team = teams.first {
                   return team.value(forKey: "isTeamFav") as? Bool ?? false
               }
           } catch {
               print("Error retrieving team: \(error.localizedDescription)")
           }
        return false
    }
}
