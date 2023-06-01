//
//  HomeViewController.swift
//  Sports
//
//  Created by Youssef on 25/05/2023.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    let imageArr = ["football","bascket-ball","tennis","crickit"]
    let titlesArr = ["FootBall", "BasketBall","Tennis","Cricket"]
    var timer: Timer?
    var timerCount: Int = 5
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCollectionView.register(UINib(nibName: "SportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SportsCollectionViewCell")
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width:sportsCollectionView.frame.width/2 - 40,height: sportsCollectionView.frame.height/2 - 50)
//        layout.scrollDirection = .vertical
//        sportsCollectionView.collectionViewLayout = layout
    }
}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SportsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionViewCell", for: indexPath) as! SportsCollectionViewCell
        cell.sportLabel.text = titlesArr[indexPath.row]
        cell.sportImage.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !InternetCheker.isInternetAvailable(){
            showAlertView()
        }else{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let next  = story.instantiateViewController(withIdentifier: "LeagesViewController") as! LeagesViewController
            next.sportName = titlesArr[indexPath.row].lowercased()
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
        }
      
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
         return CGSize(width: self.sportsCollectionView.frame.width / 2 - 40, height: self.sportsCollectionView.frame.height / 2 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension HomeViewController{
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
