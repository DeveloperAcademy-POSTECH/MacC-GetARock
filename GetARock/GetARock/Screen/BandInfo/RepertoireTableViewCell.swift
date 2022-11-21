//
//  RepertoireTableViewCell.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/21.
//

import UIKit

class RepertoireTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repertoireLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    }

}
