//
//  LeagesViewController.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit
import Reachability
import RappleProgressHUD
class LeagesViewController: UIViewController {
    
    @IBOutlet weak var leagesTableView: UITableView!
    //searching outlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leaguesTrailing: NSLayoutConstraint!
    @IBOutlet weak var leaguesLeading: NSLayoutConstraint!
    @IBOutlet weak var textFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    var timer: Timer?
    var timerCount: Int = 5
    let reachability = try! Reachability()
    var sportName = ""
    var leagueList : [League] = []
    var filteredLeagesList : [League] = []
    var filtered = false
    var leagueViewModel : LeagueViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        leagesTableView.register(UINib(nibName: "LeagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagesTableViewCell")
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: .gray, screenBG: .gray, progressBG: .black, progressBarBG: .gray, progreeBarFill: .gray, thickness: 4)
        RappleActivityIndicatorView.startAnimating(attributes:attributes)
        leagueViewModel = LeagueViewModel()
        leagueViewModel?.getLeagues(sportName: sportName)
        leagueViewModel?.bindListToLeagueTableViewController = { () in
            DispatchQueue.main.async {
                
                self.leagueList = self.leagueViewModel?.leagueList ?? []
                self.leagesTableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSearch (_ sender:Any) {
        if textFieldWidth.constant == 0 {
            UIView.animate(withDuration: 0.7) {
                self.textFieldWidth.constant = (self.topView.layer.frame.width) - 25
                self.leaguesLeading.constant = 10
                self.leaguesTrailing.constant = 15
                self.placeHolder(textField: self.searchTextField, PlaceHolder: "Enter League name", Color: UIColor.white)
                self.searchTextField.becomeFirstResponder()
                self.view.layoutIfNeeded()
            }
        }
        else {
            print("Search is Done!")
        }
    }
    func placeHolder (textField:UITextField,PlaceHolder:String , Color:UIColor) {
        textField.attributedPlaceholder = NSAttributedString(string: PlaceHolder,
                attributes: [NSAttributedString.Key.foregroundColor: Color])
    }
    
     func dismissKeyPad() {
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.7) {
            self.textFieldWidth.constant = 0
            self.leaguesLeading.constant = 124
            self.leaguesTrailing.constant = 151.67
            //self.PlaceHolder(textField: self.SearchTextField, PlaceHolder: "Enter League name", Color: UIColor.white)
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyPad()
    }
}

extension LeagesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredLeagesList.isEmpty {
            return filteredLeagesList.count
        }
        return filtered ? 0 : leagueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagesTableViewCell") as! LeagesTableViewCell
        if filtered{
            cell.leageNameLabel.text = filteredLeagesList[indexPath.row].league_name
            cell.leagesImageView.setImageUsinKingFisherPod(filteredLeagesList[indexPath.row].league_logo ?? "")
        }else{
            cell.leageNameLabel.text = leagueList[indexPath.row].league_name
            cell.leagesImageView.setImageUsinKingFisherPod(leagueList[indexPath.row].league_logo ?? "")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 7
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !InternetCheker.isInternetAvailable(){
            self.showAlertView()
        } else{
            if sportName == "tennis"{
                let alert = UIAlertController(title: nil, message: "Sorry, this league has no information right now", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alert.addAction(okAction)
                   present(alert, animated: true, completion: nil)

            } else {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let next  = story.instantiateViewController(withIdentifier: "LeageDetailsViewController") as! LeageDetailsViewController
                next.nameOfSport = sportName
                next.idOfLeague = filtered ? filteredLeagesList[indexPath.row].league_key : leagueList[indexPath.row].league_key
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: true, completion: nil)
            }
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
extension LeagesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyPad()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            
            if string.count == 0 {
                filterText(String(text.dropLast()))
            }
            else {
                filterText(text+string)
            }
        }
        
        return true
    }
    override func didChangeValue(forKey key: String) {
        if key == "" {
            dismissKeyPad()
        }else{
            filteredLeagesList.removeAll()
            
            for string in leagueList  {
                if string.league_name!.lowercased().starts(with: key.lowercased()) {
                    filteredLeagesList.append(string)
                }
            }
            self.leagesTableView.reloadData()
            filtered = true
        }
    }
    func filterText (_ query: String) {
        filteredLeagesList.removeAll()
        for string in leagueList {
            if string.league_name!.lowercased().starts(with: query.lowercased()){
                filteredLeagesList.append(string)
            }
        }
        self.leagesTableView.reloadData()
        filtered = true
    }
}
