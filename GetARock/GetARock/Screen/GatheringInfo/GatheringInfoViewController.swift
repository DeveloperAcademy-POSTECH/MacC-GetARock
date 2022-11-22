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
    @IBOutlet weak var conditionContainer: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    
    @IBOutlet weak var ellipsis: UIButton!
    //    var actionSheet = ActionSheet()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionContainer.layer.cornerRadius = 15
        conditionContainer.layer.borderWidth = 2
        conditionContainer.layer.borderColor = UIColor.white.cgColor
        
    }
   
    @IBAction func ellipsis(_ sender: UIButton) {
         showActionSheet()
        
        
    }
    
}
