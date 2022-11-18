//
//  GatherockListCell.swift
//  GetARock
//
//  Created by Admin on 2022/11/18.
//

import UIKit

class GatherockListCell: UITableViewCell {

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventState: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
