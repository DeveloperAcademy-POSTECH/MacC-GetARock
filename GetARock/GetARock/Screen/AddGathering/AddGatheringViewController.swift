//
//  AddGatheringViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/11/21.
//

import UIKit

class AddGatheringViewController: UIViewController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }

    // MARK: - Method

    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
