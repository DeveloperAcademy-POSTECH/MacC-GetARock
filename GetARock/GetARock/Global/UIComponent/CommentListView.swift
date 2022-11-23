//
//  GuestBookUIView.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class CommentListView: UIView {

    // MARK: - View

    private var totalListNumber: UILabel = {
        $0.text = "총 11개"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let tableView = {
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset.left = 16
        $0.separatorInset.right = 16
        $0.separatorColor = .dividerBlue
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attribute()
        setupLayout()
    }

    // MARK: - Method

    private func attribute() {
        self.backgroundColor = .modalBackgroundBlue
        setupCommentList()
    }

    private func setupCommentList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CommentTableViewCell.self,
            forCellReuseIdentifier: "CommentTableViewCell"
        )
    }

    private func setupLayout() {
        self.addSubview(totalListNumber)
        NSLayoutConstraint.activate([
            totalListNumber.topAnchor.constraint(equalTo: self.topAnchor),
            totalListNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        self.addSubview(tableView)
        tableView.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalListNumber.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension CommentListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

// MARK: - UITableViewDataSource

extension CommentListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CommentTableViewCell",
            for: indexPath
        ) as? CommentTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
