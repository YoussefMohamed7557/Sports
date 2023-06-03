//
//  LeageDetailsViewController.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit
import Reachability
import RappleProgressHUD
class LeageDetailsViewController: UIViewController {

    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    var timer: Timer?
    var timerCount: Int = 5
    let reachability = try! Reachability()
    var nameOfSport = ""
    var idOfLeague:Int?
    var upComingList : [UpCommingEvent]?
    var latestEventsList : [LatestEvents]?
    var teamsList :[Teams]?
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingEventsCollectionView.register(UINib(nibName: "UpComingEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpComingEventCollectionViewCell")
        latestEventsCollectionView.register(UINib(nibName: "LatestEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCollectionViewCell")
        teamsCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCollectionViewCell")
        upComingList = []
        latestEventsList = []
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: .gray, screenBG: .gray, progressBG: .black, progressBarBG: .gray, progreeBarFill: .gray, thickness: 4)
        RappleActivityIndicatorView.startAnimating(attributes:attributes)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        //checkIfThereIsNoEvents()
        let leagueDetailVM = LeagueDetailsViewModel()
        
        leagueDetailVM.getUpccoming(sportName: nameOfSport, leagueId: idOfLeague!)
        leagueDetailVM.bindUpComingListToLeagueDetailsVC = { () in
                DispatchQueue.main.async {
                self.upComingList = leagueDetailVM.upComingList
                self.upComingEventsCollectionView.reloadData()
            }
        }
        leagueDetailVM.getLastesEvent(sportName: nameOfSport, leagueId: idOfLeague!)
        leagueDetailVM.bindLatestEventListToLeagueDetailsVC = { () in
            DispatchQueue.main.async {
                self.latestEventsList = leagueDetailVM.latestEventsList
                self.latestEventsCollectionView.reloadData()
            }
        }
        leagueDetailVM.getTeams(sportName: nameOfSport, leagueId:idOfLeague!)
        leagueDetailVM.bindTeamsListToLeagueDetailsVC = { () in
            DispatchQueue.main.async {
                self.teamsList = leagueDetailVM.teamsList
                self.teamsCollectionView.reloadData()
            }
        }
        checkIfThereIsNoEvents()
    }
    func checkIfThereIsNoEvents(){
        RappleActivityIndicatorView.stopAnimation()
        if self.upComingList?.count == 0 && self.latestEventsList?.count == 0 && teamsList?.count == 0{
            let alert = UIAlertController(title: nil, message: "Sorry, this league has no information right now", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
        }
        
    }
}
extension LeageDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems = 0
        switch collectionView.tag {
        case 0:
            numberOfItems = upComingList?.count ?? 0
        case 1:
            numberOfItems = latestEventsList?.count ?? 0
        case 2:
            numberOfItems = teamsList?.count ?? 0
        default:
            numberOfItems = 0
        }
        return numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventCollectionViewCell", for: indexPath) as! UpComingEventCollectionViewCell
            cell.awayClubImageView.setImageUsinKingFisherPod(upComingList![indexPath.row].away_team_logo ?? "")
                cell.awayClubName.text = upComingList![indexPath.row].event_away_team
                cell.homeClubImageView.setImageUsinKingFisherPod(upComingList![indexPath.row].home_team_logo ?? "")
                cell.homeClubName.text = upComingList![indexPath.row].event_home_team
                cell.dateLabel.text = upComingList![indexPath.row].event_date
                cell.timeLabel.text = upComingList![indexPath.row].event_time
                return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCollectionViewCell", for: indexPath) as! LatestEventCollectionViewCell
            cell.awayClubImageView.setImageUsinKingFisherPod(latestEventsList![indexPath.row].away_team_logo ?? "")
                cell.awayClubNameLabel.text = latestEventsList![indexPath.row].event_away_team
                cell.homeClubImageView.setImageUsinKingFisherPod(latestEventsList![indexPath.row].home_team_logo ?? "")
                cell.homeClubNameLabel.text = latestEventsList![indexPath.row].event_home_team
                cell.dateLabel.text = latestEventsList![indexPath.row].event_date
                cell.timeLabel.text = latestEventsList![indexPath.row].event_time
                cell.scoreLabel.text = latestEventsList![indexPath.row].event_final_result
                return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCollectionViewCell", for: indexPath) as! TeamsCollectionViewCell
                cell.teamImageView.setImageUsinKingFisherPod(teamsList![indexPath.row].team_logo ?? "")
                cell.teamName.text = teamsList![indexPath.row].team_name
                return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventCollectionViewCell", for: indexPath) as! UpComingEventCollectionViewCell
                return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2{
            if !InternetCheker.isInternetAvailable(){
                self.showAlertView()
            }else if nameOfSport == "basketball" || nameOfSport == "cricket"{
                let alert = UIAlertController(title: nil, message: "Sorry, this team has no more information", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alert.addAction(okAction)
                   present(alert, animated: true, completion: nil)
            }else{
                let story = UIStoryboard(name: "Main", bundle: nil)
                let next  = story.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                next.passedTeam = teamsList![indexPath.row]
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: true, completion: nil)
            }
        }
    }
}
extension LeageDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
            IndexPath) -> CGSize {
            switch collectionView.tag {
            case 0:
                return CGSize(width: collectionView.frame.width - 16 , height: collectionView.frame.height)
            case 1:
              return CGSize(width: collectionView.frame.width - 16 , height: 100)
            case 2:
                 let w1 = collectionView.frame.width - (15 * 2)
                 let cell_width = (w1 - (15 * 2)) / 3
                 return CGSize(width: cell_width, height: collectionView.frame.height)
            default:
                return CGSize(width: 0 , height: 0)
            }
    }
}
extension LeageDetailsViewController{
    func showAlertView() {
        let alertController = UIAlertController(title: "Attention", message: "you are offline try reconnect", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Try again", style: .default)
        okAction.isEnabled = false
        alertController.addAction(okAction)
        present(alertController, animated: true) {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDownTimer), userInfo: nil, repeats: true)
        }
    }
    @objc func countDownTimer() {
        if timerCount == 0 {
            timerCount = 5
        }
        timerCount -= 1
        guard let alertController = presentedViewController as? UIAlertController else {return}
        let okAction = alertController.actions.first
        if timerCount == 0 || InternetCheker.isInternetAvailable(){
            timer?.invalidate()
            timer = nil
            okAction?.setValue("Ok", forKey: "title")
            okAction?.isEnabled = true
        } else {
            okAction?.setValue("Ok (\(timerCount))", forKey: "title")
        }
    }
}
// https://apiv2.allsportsapi.com/football/?met=Livescores&leagueId=5&from=2022-05-09&to=2024-02-09&APIkey=70bb2b4fc7be3974f347c9c96b60d37dbb4e557b8e75a7c13a1355bdd4e9c48c
