//
//  BandTimelineViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "BandTimelineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BandTimelineCell.className)
    }
}

// MARK: - UITableViewDataSource

extension BandTimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return gathering.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandTimelineCell.className, for: indexPath) as? BandTimelineCell else { return UITableViewCell() }
        
//        cell.title.text = gathering[indexPath.row].title
//        cell.startTime.text = gathering[indexPath.row].date
//        let labelType = gathering[indexPath.row].status
//        if labelType == .recruiting || labelType == .progressing {
//            cell.status.text = labelType.toKorean()
//        } else {
//            cell.status.isHidden = true
//        }
//
//        if indexPath.row == 0 {
//            cell.topLine.isHidden = true
//        } else if indexPath.row == gathering.count - 1 {
//            cell.bottomLine.isHidden = true
//        }
        
        return cell
    }
}
