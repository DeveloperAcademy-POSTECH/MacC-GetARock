//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController {

    @IBOutlet weak var condtion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        condtion.backgroundColor = .systemPurple
        condtion.layer.cornerRadius = 15
        condtion.layer.borderWidth = 2
        condtion.layer.borderColor = UIColor.white.cgColor
        
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
