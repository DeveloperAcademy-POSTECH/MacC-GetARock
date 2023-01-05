//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2023/01/05.
//

        import UIKit

        final class GatheringInfoViewController: UIViewController {
            
            // MARK: - properties
            
            @IBOutlet weak var conditionView: UIView!
            @IBOutlet weak var statusLabel: UILabel!
            @IBOutlet weak var ellipsisButton: UIButton!
            @IBOutlet weak var gatheringTitleLabel: UILabel!
            @IBOutlet weak var bandNameLabel: UILabel!
            @IBOutlet weak var gatheringDateLabel: UILabel!
            @IBOutlet weak var gatheringLocationLabel: UILabel!
            @IBOutlet weak var describtionLabel: UILabel!
            @IBOutlet weak var commentsView: UIView!

            // MARK: - View Life Cycle
            
            override func viewDidLoad() {
                super.viewDidLoad()
                conditionView.layer.cornerRadius = 15
                conditionView.layer.borderWidth = 2
                conditionView.layer.borderColor = UIColor.white.cgColor
                
            }
            
            // MARK: - Method
            
            @IBAction func touchUpInsideEllipsis(_ sender: UIButton) {
                showActionSheet()
            }
            
        }

        // MARK: - extension Reportable Method

        extension GatheringInfoViewController: Reportable {
            func alertActionButtonPressed() {
                print("삭제에 성공했습니다.")
            }
        }
