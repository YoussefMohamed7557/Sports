//
//  FavouriteItemsViewController.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import UIKit
import Reachability
class FavouriteItemsViewController: UIViewController {
    @IBOutlet weak var favouriteItemsTableView: UITableView!
    var favouriteViewModel : FavouriteViewModel?
    var favouriteTeams : [Teams]?
    var timer: Timer?
    var timerCount: Int = 5
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteItemsTableView.register(UINib(nibName: "LeagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagesTableViewCell")
        favouriteViewModel = FavouriteViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        favouriteViewModel?.getFavouriteTeams()
        DispatchQueue.main.async {
            self.favouriteTeams = self.favouriteViewModel?.favList
            self.favouriteItemsTableView.reloadData()
        }
    }
}
extension FavouriteItemsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteTeams?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagesTableViewCell") as! LeagesTableViewCell
        cell.leageNameLabel.text = favouriteTeams![indexPath.row].team_name
        cell.leagesImageView.setImageUsinKingFisherPod(favouriteTeams![indexPath.row].team_logo ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 7
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !InternetCheker.isInternetAvailable(){
            self.showAlertView()
        }else{
            favouriteViewModel?.getTeamDetails(teamId: favouriteTeams![indexPath.row].team_key!)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let next  = story.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            favouriteViewModel?.bindTeamListToFavouriteTableViewController = {
                 () in
                next.passedTeam = self.favouriteViewModel?.teamDetail
                DispatchQueue.main.async {
                    next.modalPresentationStyle = .fullScreen
                    self.present(next, animated: true, completion: nil)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteCell = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
            let alert = UIAlertController(title: "Delete Team", message: "Are you sure you want to delete this team from favourite?", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                   self.favouriteViewModel?.deleteTeam(team: self.favouriteTeams![indexPath.row])
                   self.favouriteViewModel?.getFavouriteTeams()
                   DispatchQueue.main.async {
                       self.favouriteTeams = self.favouriteViewModel?.favList
                       print("favouriteList")
                       self.favouriteItemsTableView.reloadData()
                   }
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
        deleteCell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        deleteCell.image = #imageLiteral(resourceName: "pin")
        let perform = UISwipeActionsConfiguration(actions: [deleteCell])
        //to prevent first action when we hard swip
        perform.performsFirstActionWithFullSwipe = false
        return perform
    }
}
extension FavouriteItemsViewController{
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
