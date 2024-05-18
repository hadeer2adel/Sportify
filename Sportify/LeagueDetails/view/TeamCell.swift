//
//  TeamCell.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 17/05/2024.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //rounded corner
        contentView.layer.cornerRadius = 50
        contentView.layer.masksToBounds = true
        
        //color rounded border
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 50
        clipsToBounds = true
    }

}
