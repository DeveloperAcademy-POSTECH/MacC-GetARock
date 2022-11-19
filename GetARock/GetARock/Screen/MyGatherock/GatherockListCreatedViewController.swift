//
//  GatherockListCreatedViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/18.
//

import UIKit

class GatherockListCreatedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "GatherockCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: GatherockListCell.className)
    }
    
}

extension GatherockListCreatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GatherockListCell.className, for: indexPath) as? GatherockListCell else { return UITableViewCell() }

        return cell
    }
}

extension GatherockListCreatedViewController: UITableViewDelegate {
    
}
