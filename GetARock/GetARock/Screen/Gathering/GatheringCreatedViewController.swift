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
            tableView.reloadData()
        }
    }
    
    // MARK: - Sample Data
    
    enum StateType {
        case finding
        case active
        case finish
        case cancel
    }
    
    struct Gathering {
        var title: String
        var date: String
        var state: StateType
    }
    
    private var gathering = [
        Gathering(title: "동성로 합동 버스킹 합니다!", date: "22.12.05 13:00", state: .finding),
        Gathering(title: "블랙로즈 합주 드럼 한 분 구합니다", date: "22.11.20 14:00", state: .active),
        Gathering(title: "몰라 아무거나 쳐보는 중입니다.", date: "22.11.20 12:00", state: .active),
        Gathering(title: "두 줄 만들기 해보는 중, 몰라 아무거나 쳐보는 중입니다1234.", date: "22.11.18 21:00", state: .cancel),
        Gathering(title: "대체텍스트 대체텍스트 대체텍스트", date: "22.11.18 16:00", state: .finish),
        Gathering(title: "두 줄 만들기 대체텍스트 대체텍스트 대체텍스트 대체텍스트 대체텍스트 22", date: "22.11.12 18:00", state: .finish)
    ]
    
    func labelType(for type: StateType) -> String {
        let text: String
        switch type {
        case .finding: text = "모집중"
        case .active: text = "진행중"
        case .finish: text = "완 료"
        case .cancel: text = "취소됨"
        }
        return text
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .modalBackgroundBlue
        tableView.backgroundColor = .modalBackgroundBlue
        let nibName = UINib(nibName: "GatheringCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: GatheringCell.className)
    }
    
}

// MARK: - UITableViewDataSource

extension GatheringCreatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch gatheringListType {
        case .gatheringCreated:
            return gathering.count
        case .gatheringJoined:
            return gathering.count > 2 ? gathering.count - 2 : gathering.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GatheringCell.className, for: indexPath) as? GatheringCell else { return UITableViewCell() }
        
        switch gatheringListType {
        case .gatheringCreated:
            break
        case .gatheringJoined:
            break
        }
        cell.title.text = gathering[indexPath.row].title
        cell.startTime.text = gathering[indexPath.row].date
        cell.state.text = labelType(for: gathering[indexPath.row].state)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GatheringCreatedViewController: UITableViewDelegate {
    
}
