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
    @IBOutlet weak var gatheringTitleLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var gatheringDateLabel: UILabel!
    @IBOutlet weak var gatheringLocationLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var ellipsisButton: UIButton!
    
    var gatheringInfo: GatheringInfo = MockData.gatherings[3]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.layer.borderColor = UIColor.white.cgColor
        connectWithData()
        
    }
    
    // MARK: - Method
    
    func connectWithData() {
        gatheringTitleLabel.text = gatheringInfo.gathering.title
        bandNameLabel.text = gatheringInfo.gathering.host.band.name
        gatheringDateLabel.text = gatheringInfo.gathering.date.toString(format: DateFormatLiteral.standard )
        gatheringLocationLabel.text = gatheringInfo.gathering.location.address
        describtionLabel.text = gatheringInfo.gathering.introduction
    }
    
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
    
    @IBAction func touchUpInsideEllipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
}
