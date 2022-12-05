//
//  ReportReasonListCell.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/22.
//

import UIKit

final class ReportReasonListCell: UITableViewCell {
    
    // MARK: - property
    
    @IBOutlet weak var reportReason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
