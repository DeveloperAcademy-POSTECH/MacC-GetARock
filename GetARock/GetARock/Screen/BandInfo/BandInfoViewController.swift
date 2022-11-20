//
//  BandInfoViewController.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/19.
//

import UIKit

class BandInfoViewController: UIViewController {
    
    @IBOutlet weak var bandMemberLabel: UILabel!
    private var bandMemberNumber: Int = 7
    
    override func viewDidLoad() {
        bandMemberLabel.text = "밴드 멤버 (\(bandMemberNumber)명)"
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
