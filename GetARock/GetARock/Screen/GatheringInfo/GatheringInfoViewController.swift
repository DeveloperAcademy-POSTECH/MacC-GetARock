//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController {
    
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
    

//        actionSheet.showActionSheet()

    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { action in
            print("delete")
        }
        let report = UIAlertAction(title: "신고하기", style: .default) { action in
            print("report")
        }
        
        actionSheet.addAction(report)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}
