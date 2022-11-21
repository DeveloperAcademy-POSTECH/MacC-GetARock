//
//  BandTimelineViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "BandTimelineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BandTimelineCell.className)
    }
}

// MARK: - UITableViewDataSource

extension BandTimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandTimelineCell.className, for: indexPath) as? BandTimelineCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BandTimelineViewController: UITableViewDelegate {
    
}
