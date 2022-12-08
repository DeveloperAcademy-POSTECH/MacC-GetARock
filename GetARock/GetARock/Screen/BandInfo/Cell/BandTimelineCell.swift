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
    @IBOutlet weak var statusBackground: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusBackground.fillMainGradient()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
