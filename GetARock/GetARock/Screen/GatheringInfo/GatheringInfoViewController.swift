//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController {
    @IBOutlet weak var conditionContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionContainer.layer.cornerRadius = 15
        conditionContainer.layer.borderWidth = 2
        conditionContainer.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
