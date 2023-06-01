//
//  LeagesTableViewCell.swift
//  Sports
//
//  Created by Youssef on 27/05/2023.
//

import UIKit

class LeagesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagesImageBackgroundView: UIView!
    @IBOutlet weak var leagesImageView: UIImageView!
    @IBOutlet weak var leageNameLabel: UILabel!
    @IBOutlet weak var spuerBackgroundView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.spuerBackgroundView.layer.cornerRadius = spuerBackgroundView.frame.height / 6
        self.spuerBackgroundView.layer.borderWidth = 1
        self.spuerBackgroundView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#363636").cgColor
        leagesImageView.applyshadowWithCorner(containerView: leagesImageBackgroundView, cornerRadious: leagesImageBackgroundView.frame.height / 2, shadowColor: "#363636")
    }
}
