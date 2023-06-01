//
//  LatestEventCollectionViewCell.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit

class LatestEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var homeClubBackgroundView: UIView!
    @IBOutlet weak var homeClubImageView: UIImageView!
    @IBOutlet weak var homeClubNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var awayClubBackgroundView: UIView!
    @IBOutlet weak var awayClubImageView: UIImageView!
    @IBOutlet weak var awayClubNameLabel: UILabel!
    @IBOutlet weak var superBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.homeClubImageView.applyshadowWithCorner(containerView: homeClubBackgroundView, cornerRadious: 0, shadowColor: "#363636")
        self.awayClubImageView.applyshadowWithCorner(containerView: awayClubBackgroundView, cornerRadious: 0, shadowColor: "#363636")
        superBackgroundView.layer.cornerRadius = 12
        self.superBackgroundView.layer.borderWidth = 1
        self.superBackgroundView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#363636").cgColor
    }

}
