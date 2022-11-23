//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController, Reportable {
    var viewControllerToPresentWhenReported: UIViewController = ReportReasonListController()
    
    // MARK: - properties
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    
    @IBOutlet weak var ellipsis: UIButton!
    //    var actionSheet = ActionSheet()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.layer.borderColor = UIColor.white.cgColor
        
    }
   
    @IBAction func ellipsis(_ sender: UIButton) {
         showActionSheet()
    
    }
    
}
