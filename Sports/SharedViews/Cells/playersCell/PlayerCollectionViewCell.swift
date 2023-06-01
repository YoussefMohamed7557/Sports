//
//  PlayerCollectionViewCell.swift
//  Sports
//
//  Created by Youssef on 28/05/2023.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var superBacgroundView: UIView!
    @IBOutlet weak var playerImageBackgroundView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superBacgroundView.layer.cornerRadius = 12
        self.superBacgroundView.layer.borderWidth = 1
        self.superBacgroundView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#363636").cgColor
    }

}
