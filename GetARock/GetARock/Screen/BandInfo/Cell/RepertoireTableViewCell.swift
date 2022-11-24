//
//  RepertoireTableViewCell.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/21.
//

import UIKit

class RepertoireTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repertoireCellView: UIView!
    @IBOutlet weak var repertoireLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        repertoireCellView.backgroundColor = UIColor.backgroundBlue
        repertoireCellView.layer.cornerRadius = 15
        repertoireCellView.layer.borderWidth = 1
        repertoireCellView.layer.borderColor = UIColor.dividerBlue.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}