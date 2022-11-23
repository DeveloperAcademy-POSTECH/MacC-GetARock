//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.layer.borderColor = UIColor.white.cgColor
        
    }
    
}
