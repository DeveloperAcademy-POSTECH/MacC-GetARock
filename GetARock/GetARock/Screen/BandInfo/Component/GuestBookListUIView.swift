//
//  GuestBookUIView.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

struct TempData {
    let bandName: String
    let comment: String
    var commentDate: Date
}

class GuestBookListView: UIView {
    
    var tempGuestBookData: [TempData] = []
    
    private let reuseIdentifier = "GusetBookTableViewCell"
    
    lazy var listCount: UILabel = {
        $0.text = "총 11개"
        $0.textColor = .systemPink
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let tableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        setGuestBookList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GusetBookTableViewCell.self, forCellReuseIdentifier: "GusetBookTableViewCell")
        
        //        tempGuestBookData = [
        //            TempData(bandName: "블랙로즈", comment: "안녕하십십시오", commentDate: Date()),
        //            TempData(bandName: "로젤리아", comment: "안녕하십세요 로젤리아 입니다.", commentDate: Date()),
        //            TempData(bandName: "오아시스", comment: "하우매니피플체인지? 하우매니라이브 리빙 스트레인지", commentDate: Date()),
        //            TempData(bandName: "건즈앤로지스", comment: "잘 보고 갑니다^^", commentDate: Date())
        //        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setGuestBookList() {
        
        self.addSubview(listCount)
        NSLayoutConstraint.activate([
            listCount.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            listCount.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            )
        ])
        
        self.addSubview(tableView)
        tableView.backgroundColor = .appColor(.modalBackgroundBlue)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: listCount.bottomAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            )
        ])
    }
}

// MARK: - UITableViewDelegate
extension GuestBookListView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension GuestBookListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return tempGuestBookData.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GusetBookTableViewCell", for: indexPath) as? GusetBookTableViewCell else { return UITableViewCell() }
        return cell
    }
}
