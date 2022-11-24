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
//        return gathering.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GatheringListCell.className, for: indexPath) as? GatheringListCell else { return UITableViewCell() }
        
//        cell.title.text = gathering[indexPath.row].title
//        cell.startTime.text = gathering[indexPath.row].date
//        cell.state.text = labelType(for: gathering[indexPath.row].state)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GatheringListViewController: UITableViewDelegate {
    
}
