//
//  EventCell.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 17/05/2024.
//

import UIKit

class EventCell: UICollectionViewCell {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var teamName_2: UILabel!
    @IBOutlet weak var teamName_1: UILabel!
    @IBOutlet weak var teamImage_2: UIImageView!
    @IBOutlet weak var teamImage_1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //rounded corner
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        
        //color rounded border
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 30
        clipsToBounds = true

    }

}
