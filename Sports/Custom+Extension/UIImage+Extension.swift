//
//  CustomImageView.swift
//  Sports
//
//  Created by Youssef on 24/05/2023.
//

import UIKit
import Kingfisher
extension UIImageView {
    
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat , shadowColor: String){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor().hexStringToUIColor(hex: shadowColor).cgColor
        containerView.layer.shadowOpacity = 4
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 1
        containerView.layer.cornerRadius = cornerRadious
       // containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
    func setImageUsinKingFisherPod( _ urlString:String){
        guard let handledUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
        guard let imageURL = URL(string: handledUrl) else {return}
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL, placeholder: UIImage(named: "No_image"), options: [.transition(.fade(0.8))])
    }
}

