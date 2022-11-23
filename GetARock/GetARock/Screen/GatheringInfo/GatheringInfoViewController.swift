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
    @IBOutlet weak var gatheringTitle: UILabel!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var gatheringDate: UILabel!
    @IBOutlet weak var gatheringLocation: UILabel!
    @IBOutlet weak var describtion: UILabel!
    @IBOutlet weak var ellipsis: UIButton!
    
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
        gatheringTitle.text = gatheringInfo.gathering.title
        bandName.text = gatheringInfo.gathering.host.band.name
        gatheringDate.text = gatheringInfo.gathering.date.toString(format: DateFormatLiteral.standard )
        gatheringLocation.text = gatheringInfo.gathering.location.address
        describtion.text = gatheringInfo.gathering.introduction
    }
    
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
    
    @IBAction func ellipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
}
