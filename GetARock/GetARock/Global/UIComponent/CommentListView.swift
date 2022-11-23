//
//  GuestBookUIView.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

enum CommentListEntryPoint {
    case visitorComment
    case gatheringComment
}

class CommentListView: UIView {

    // MARK: - Properties

    private var vistorCommentData: VisitorCommentInfo?
    private var gatheringComment: GatheringCommentInfo?
    private var entryPoint: CommentListEntryPoint

    // MARK: - View

    private let totalListNumberLabel: UILabel = {
        $0.text = "총 \(MockData.visitorComments.count)개"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let visitorCommentButton: CommentCreateButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setupButtonTitle(title: "방명록 남기기")
        return $0
    }(CommentCreateButton())

    private let tableView = {
        $0.showsVerticalScrollIndicator = false
//        $0.separatorInset.left = 16
//        $0.separatorInset.right = 16
        $0.separatorColor = .dividerBlue
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    // MARK: - Init

    init(entryPoint: CommentListEntryPoint) {
        self.entryPoint = entryPoint
        super.init(frame: .zero)
        attribute()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            forCellReuseIdentifier: CommentTableViewCell.className
        )
    }

    private func setupLayout() {
        self.addSubview(totalListNumberLabel)
        NSLayoutConstraint.activate([
            totalListNumberLabel.topAnchor.constraint(equalTo: self.topAnchor),
            totalListNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        self.addSubview(tableView)
        tableView.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalListNumberLabel.bottomAnchor),
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
        switch entryPoint {
        case .visitorComment :
            return MockData.visitorComments.count
        case .gatheringComment:
            return MockData.gatheringComments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        switch entryPoint {
        case .visitorComment :
            cell.bandNameLabel.text = MockData.bands[indexPath.row].band.name
            cell.commentTextLabel.text = MockData.visitorComments[indexPath.row].comment.content
//            cell.commentDate.text = MockData.visitorComments[indexPath.row].comment.createdAt
        case .gatheringComment:
//            cell.bandName.text = MockData.bands[indexPath.row].band.name
            cell.bandNameLabel.text = MockData.gatheringComments[indexPath.row].comment.author.band.name
            cell.commentTextLabel.text = MockData.gatheringComments[indexPath.row].comment.content
        }
        return cell
    }
}
