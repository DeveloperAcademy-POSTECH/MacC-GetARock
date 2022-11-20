//
//  GatherockListCreatedViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/18.
//

import UIKit

// MARK: - sample data
enum stateType {
    case finding
    case active
    case finish
    case cancel
}

struct Gatherock {
    var title: String
    var date: String
    var state: stateType
    
    init(title: String, date: String, state: stateType){
        self.title = title
        self.date = date
        self.state = state
    }
}

class GatherockListCreatedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var event = [
        Gatherock(title: "동성로 합동 버스킹 합니다!", date: "22.12.05 13:00", state: .finding),
        Gatherock(title: "블랙로즈 합주 드럼 한 분 구합니다", date: "22.11.20 14:00", state: .active),
        Gatherock(title: "몰라 아무거나 쳐보는 중입니다.", date: "22.11.20 12:00", state: .active),
        Gatherock(title: "몰라 아무거나 쳐보는 중입니다1234.", date: "22.11.18 21:00", state: .cancel),
        Gatherock(title: "대체텍스트 대체텍스트 대체텍스트", date: "22.11.18 16:00", state: .finish),
        Gatherock(title: "대체텍스트 대체텍스트 대체텍스트 22", date: "22.11.12 18:00", state: .finish),
    ]
    
    func buttonType(for type: stateType) -> String {
        let text: String
        switch type {
        case .finding: text = "모집중"
        case .active: text = "진행중"
        case .finish: text = "완 료"
        case .cancel: text = "취소됨"
        }
        return text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "GatherockCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: GatherockListCell.className)
    }
    
}

extension GatherockListCreatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GatherockListCell.className, for: indexPath) as! GatherockListCell
        
        cell.eventTitle.text = event[indexPath.row].title
        cell.startTime.text = event[indexPath.row].date
        cell.eventState.setTitle(buttonType(for: event[indexPath.row].state), for: .normal)
        return cell
    }
}

extension GatherockListCreatedViewController: UITableViewDelegate {
    
}
