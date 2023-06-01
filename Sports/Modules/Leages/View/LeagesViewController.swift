//
//  LeagesViewController.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit
import Reachability
class LeagesViewController: UIViewController {
    
    @IBOutlet weak var leagesTableView: UITableView!
    var timer: Timer?
    var timerCount: Int = 5
    let reachability = try! Reachability()
    var sportName = ""
    var leagueList : [League]?
    var leagueViewModel : LeagueViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        leagesTableView.register(UINib(nibName: "LeagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagesTableViewCell")
        leagueViewModel = LeagueViewModel()
        leagueViewModel?.getLeagues(sportName: sportName)
        leagueViewModel?.bindListToLeagueTableViewController = { () in
            DispatchQueue.main.async {
                self.leagueList = self.leagueViewModel?.leagueList
                self.leagesTableView.reloadData()
            }
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LeagesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagesTableViewCell") as! LeagesTableViewCell
        cell.leageNameLabel.text = leagueList![indexPath.row].league_name
        cell.leagesImageView.setImageUsinKingFisherPod(leagueList![indexPath.row].league_logo ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 7
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !InternetCheker.isInternetAvailable(){
            self.showAlertView()
        } else{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let next  = story.instantiateViewController(withIdentifier: "LeageDetailsViewController") as! LeageDetailsViewController
            next.nameOfSport = sportName
            next.idOfLeague = leagueList![indexPath.row].league_key
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
        }
    }
}
extension LeagesViewController{
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
