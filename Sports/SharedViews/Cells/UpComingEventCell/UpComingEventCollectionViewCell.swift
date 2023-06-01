//
//  UpComingEventCollectionViewCell.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit

class UpComingEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var homeClubBackgroundView: UIView!
    @IBOutlet weak var homeClubImageView: UIImageView!
    @IBOutlet weak var homeClubName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var awayClubBackgroundView: UIView!
    @IBOutlet weak var awayClubImageView: UIImageView!
    @IBOutlet weak var awayClubName: UILabel!
    @IBOutlet weak var superBackgroundView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeClubImageView.applyshadowWithCorner(containerView: homeClubBackgroundView, cornerRadious: 0, shadowColor: "#363636")
        awayClubImageView.applyshadowWithCorner(containerView: awayClubBackgroundView, cornerRadious: 0, shadowColor: "#363636")
        superBackgroundView.layer.cornerRadius = 12
        self.superBackgroundView.layer.borderWidth = 1
        self.superBackgroundView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#363636").cgColor
    }

}
