//
//  ReportReasonListHeader.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/23.
//

import UIKit

class ReportReasonListHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        title.text = "123"
        subtitle.text = "123"
       }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
