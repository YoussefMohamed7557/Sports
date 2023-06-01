//
//  TeamsCollectionViewCell.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamImageBackgroundView: UIView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var superBackgroundView: UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        superBackgroundView.layer.cornerRadius = 8
        self.superBackgroundView.layer.borderWidth = 1
        self.superBackgroundView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#363636").cgColor
    }

}
