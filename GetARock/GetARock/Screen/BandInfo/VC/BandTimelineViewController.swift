//
//  BandTimelineViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    
    var bandInfo: BandInfo?
    private var gatherings: [GatheringInfo] = [] {
        didSet {
            gatherings = gatherings.filter({ gatheringInfo in
                let status = gatheringInfo.gathering.status
                return status != .canceled
            })
            tableView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGahthering()
        view.backgroundColor = .modalBackgroundBlue
        tableView.backgroundColor = .modalBackgroundBlue
        let nibName = UINib(nibName: "BandTimelineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BandTimelineCell.className)
    }
    
    // MARK: - Method
    
    private func setGahthering() {
        Task {
            self.gatherings = (try? await requestGathering()) ?? self.gatherings
        }
    }
    
    private func requestGathering() async throws -> [GatheringInfo] {
        guard let bandInfo = bandInfo else { return [] }
        let gatheringAPI = GatheringAPI()
        let abc = try await gatheringAPI.getAllOwnedGatheringInfos(owner: bandInfo.bandID)
        return abc
    }
}

// MARK: - UITableViewDataSource

extension BandTimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatherings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandTimelineCell.className, for: indexPath) as? BandTimelineCell else { return UITableViewCell() }
        
        cell.title.text = gatherings[indexPath.row].gathering.title
        cell.startTime.text = gatherings[indexPath.row].gathering.date.toString(format: DateFormatLiteral.standard)
        let labelType = gatherings[indexPath.row].gathering.status
        if labelType == .recruiting || labelType == .progressing {
            cell.status.text = labelType.toKorean()
        } else {
            cell.status.isHidden = true
        }
        
        if indexPath.row == 0 {
            cell.topLine.isHidden = true
        }
        if indexPath.row == gatherings.count - 1 {
            cell.bottomLine.isHidden = true
        }
        
        return cell
    }
}
