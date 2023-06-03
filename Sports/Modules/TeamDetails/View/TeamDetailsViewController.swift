//
//  TeamDetailsViewController.swift
//  Sports
//
//  Created by Youssef on 28/05/2023.
//

import UIKit
import Toast_Swift
class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var playersCollectionView: UICollectionView!
    @IBOutlet weak var clubLogo: UIImageView!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var clubLogoBackgroundView: UIView!
    @IBOutlet weak var isfavTeam: UIButton!
    @IBOutlet weak var clubNameLabel: UILabel!
    var playersList : [Player]?
    var teamDetailsViewModel: TeamDetailsViewModel?
    var passedTeam:Teams!
    override func viewDidLoad() {
        super.viewDidLoad()
        setubUI()
        teamDetailsViewModel = TeamDetailsViewModel()
        playersList = passedTeam?.players
        updateFavouriteButton()
    }
    @IBAction func backButtomn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func setubUI(){
        clubLogo.applyshadowWithCorner(containerView: clubLogoBackgroundView, cornerRadious: 12, shadowColor: "#363636")
        playersCollectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
        coachNameLabel.text = "Coach: \((passedTeam?.coaches?[0].coach_name ?? "not existed")!)"
        clubLogo.setImageUsinKingFisherPod(passedTeam?.team_logo ?? "")
                let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:playersCollectionView.frame.width/2.7,height: playersCollectionView.frame.height/2)
            playersCollectionView.collectionViewLayout = layout
        clubNameLabel.text = passedTeam?.team_name
    }
    @IBAction func addOrRemoveFromFavourite(_ sender: Any) {
        if teamDetailsViewModel?.isFavouriteTeam(team: passedTeam) == false{
            teamDetailsViewModel?.saveToCoreData(team: passedTeam)
            updateFavouriteButton()
            self.view.makeToast("added to favourite successfully", position: .bottom)
        }else{
            let alert = UIAlertController(title: "Delete Team", message: "Are you sure you want to delete this team from favourite?", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                   self.teamDetailsViewModel?.deleteFromCoreData(team: self.passedTeam)
                   self.updateFavouriteButton()
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               present(alert, animated: true)
        }
    }
    func updateFavouriteButton(){
        if teamDetailsViewModel?.isFavouriteTeam(team: passedTeam) == true{
            isfavTeam.setImage(UIImage(named: "heart_red"), for: .normal)
        }else{
            isfavTeam.setImage(UIImage(named: "BTNLove"), for: .normal)
        }
    }
}
extension TeamDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as! PlayerCollectionViewCell
        cell.playerImageView.setImageUsinKingFisherPod(playersList![indexPath.row].player_image ?? "")
        cell.playerNameLabel.text = playersList![indexPath.row].player_name
        return cell
    }
}
