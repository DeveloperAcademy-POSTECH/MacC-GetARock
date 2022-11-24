//
//  GatherockListCreatedViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/18.
//

import UIKit

class GatheringListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var gatheringInfos: [GatheringInfo] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "GatheringListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: GatheringListCell.className)
    }
    
}

// MARK: - UITableViewDataSource

extension GatheringListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatheringInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GatheringListCell.className, for: indexPath) as? GatheringListCell else { return UITableViewCell() }
        
        let gathering = gatheringInfos[indexPath.row].gathering
        cell.title.text = gathering.title
        cell.startTime.text = gathering.date.toString(format: DateFormatLiteral.standard)
        cell.state.text = gathering.status.toKorean()
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GatheringListViewController: UITableViewDelegate {
    
}
