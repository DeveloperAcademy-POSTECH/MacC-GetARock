//
//  BandTimelineViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var gatheringInfos: [GatheringInfo] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "BandTimelineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BandTimelineCell.className)
    }
    
    // MARK: - Method
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension BandTimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatheringInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandTimelineCell.className, for: indexPath) as? BandTimelineCell else { return UITableViewCell() }
        
        let gathering = gatheringInfos[indexPath.row].gathering
        cell.titleLabel.text = gathering.title
        cell.dateLabel.text = gathering.date.toString(format: DateFormatLiteral.standard)
        
        let statusType = gathering.status
        if statusType == .recruiting || statusType == .progressing {
            cell.statusLabel.text = statusType.toKorean()
        } else {
            cell.statusLabel.isHidden = true
        }

        if indexPath.row == 0 {
            cell.topLine.isHidden = true
        }
        if indexPath.row == (gatheringInfos.count) - 1 {
            cell.bottomLine.isHidden = true
        }
        
        return cell
    }
}
