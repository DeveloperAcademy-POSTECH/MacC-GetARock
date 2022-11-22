//
//  BandTimelineViewController.swift
//  GetARock
//
//  Created by Admin on 2022/11/21.
//

import UIKit

class BandTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Sample Data
    
    struct Gathering {
        enum Status: String {
            case recruiting
            case progressing
            case finished
            case canceled
            
            func toKorean() -> String {
                switch self {
                case .recruiting: return "모집중"
                case .progressing: return "진행중"
                case .finished: return "완료됨"
                case .canceled: return "취소됨"
                }
            }
        }
        
        /// 모임의 제목입니다.
        let title: String
        /// 모임의 진행 전/중/후 및 취소를 나타내는 상태정보입니다.
        let status: Status
        /// 모임이  이루어지는 날짜 및 시간입니다.
        let date: String
        
        init(title: String, date: String, status: Status) {
            self.title = title
            self.date = date
            self.status = status
        }
    }
    
    private var gathering = [
        Gathering(title: "동성로 합동 버스킹 합니다!", date: "22.12.05 13:00", status: .recruiting),
        Gathering(title: "블랙로즈 합주 드럼 한 분 구합니다", date: "22.11.20 14:00", status: .progressing),
        Gathering(title: "몰라 아무거나 쳐보는 중입니다.", date: "22.11.20 12:00", status: .progressing),
        Gathering(title: "두 줄 만들기 해보는 중, 몰라 아무거나 쳐보는 중입니다1234.", date: "22.11.18 21:00", status: .canceled),
        Gathering(title: "대체텍스트 대체텍스트 대체텍스트", date: "22.11.18 16:00", status: .finished),
        Gathering(title: "두 줄 만들기 대체텍스트 대체텍스트 대체텍스트 대체텍스트 대체텍스트 22", date: "22.11.12 18:00", status: .finished)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "BandTimelineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BandTimelineCell.className)
    }
}

// MARK: - UITableViewDataSource

extension BandTimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gathering.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandTimelineCell.className, for: indexPath) as? BandTimelineCell else { return UITableViewCell() }
        
        cell.title.text = gathering[indexPath.row].title
        cell.startTime.text = gathering[indexPath.row].date
        let labelType = gathering[indexPath.row].status
        if labelType == .recruiting || labelType == .progressing {
            cell.state.text = labelType.toKorean()
        } else {
            cell.state.isHidden = true
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BandTimelineViewController: UITableViewDelegate {
    
}
