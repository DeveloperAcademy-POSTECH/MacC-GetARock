//
//  GatherockListCreatedViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/18.
//

import UIKit

class GatheringCreatedViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    var gatheringListType: GatheringListType = .gatheringCreated {
        didSet {
            print(oldValue, " -> ", gatheringListType)
            tableView.reloadData()
        }
    }
    
    // MARK: - Data Property
        
    private var ownedGatherings: [GatheringInfo] = [] {
        didSet {
            if gatheringListType == .gatheringCreated {
                tableView.reloadData()
            }
        }
    }
    private var joinedGatherings: [GatheringInfo] = [] {
        didSet {
            if gatheringListType == .gatheringJoined {
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGatherings()
        view.backgroundColor = .modalBackgroundBlue
        tableView.backgroundColor = .modalBackgroundBlue
        let nibName = UINib(nibName: "GatheringCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: GatheringCell.className)
    }
    
    // MARK: - Methods
    func setGatherings() {
        Task {
            guard let myBandInfo = myBandInfo else { return }
            let gatheringAPI = GatheringAPI()
            async let ownedGatherings = gatheringAPI.getAllOwnedGatheringInfos(owner: myBandInfo.bandID)
            async let joinedGatherings = gatheringAPI.getAllJoinedGatheringInfos(participant: myBandInfo.bandID)
            self.ownedGatherings = (try? await ownedGatherings) ?? self.ownedGatherings
            self.joinedGatherings = (try? await joinedGatherings) ?? self.joinedGatherings
        }
    }
    
}

// MARK: - UITableViewDataSource

extension GatheringCreatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var gatherings: [GatheringInfo] = []
        switch gatheringListType {
        case .gatheringCreated:
            gatherings = ownedGatherings
        case .gatheringJoined:
            gatherings = joinedGatherings
        }
        return gatherings.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GatheringCell.className, for: indexPath) as? GatheringCell else { return UITableViewCell() }
        
        var gatherings: [GatheringInfo] = []
        switch gatheringListType {
        case .gatheringCreated:
            gatherings = ownedGatherings
        case .gatheringJoined:
            gatherings = joinedGatherings
        }
        
        cell.title.text = gatherings[indexPath.row].gathering.title
        cell.startTime.text = gatherings[indexPath.row].gathering.date.toString(format: DateFormatLiteral.standard)
        cell.state.text = gatherings[indexPath.row].gathering.status.toKorean()
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GatheringCreatedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let gatherings: [GatheringInfo]
        switch gatheringListType {
        case .gatheringCreated:
            gatherings = ownedGatherings
        case .gatheringJoined:
            gatherings = joinedGatherings
        }
        
        let gatheringInfo = gatherings[indexPath.row]
        guard let viewController = UIStoryboard(name: "GatheringInfoPage", bundle: nil).instantiateViewController(withIdentifier: GatheringInfoViewController.className) as? GatheringInfoViewController else { return }
        viewController.gatheringInfo = gatheringInfo
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true)
    }
}
