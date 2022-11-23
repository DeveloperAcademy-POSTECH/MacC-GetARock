//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController, Reportable {
    
    // MARK: - properties
    
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    @IBOutlet weak var ellipsisForDeleteAndReport: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    // MARK: - Method
    
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
    
    @IBAction func tabEllipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
}
