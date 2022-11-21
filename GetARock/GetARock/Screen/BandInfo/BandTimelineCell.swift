//
//  BandTimelineCell.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineCell: UITableViewCell {

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var state: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
