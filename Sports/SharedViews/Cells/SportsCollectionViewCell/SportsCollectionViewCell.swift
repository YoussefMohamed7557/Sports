//
//  SportsCollectionViewCell.swift
//  Sports
//
//  Created by Youssef on 24/05/2023.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportImageBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sportImage.applyshadowWithCorner(containerView: sportImageBackgroundView, cornerRadious: (40), shadowColor: "#363636")
    }

}
