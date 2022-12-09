//
//  BandMemberCollectionViewCell.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/20.
//

import UIKit

class BandMemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var numberOfPositionLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.dividerBlue.cgColor
        self.positionImageView.backgroundColor = UIColor.modalBackgroundBlue
    }
}
