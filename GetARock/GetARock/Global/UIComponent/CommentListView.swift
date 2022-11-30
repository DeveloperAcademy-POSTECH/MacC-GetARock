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

    private var entryPoint: CommentListEntryPoint
    
    // MARK: - View

    let totalListNumberLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    let commentWritingButton: CommentCreateButton = {
        return $0
    }(CommentCreateButton())

    let tableView = {
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset.right = 16
        $0.separatorColor = .dividerBlue
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())

    private lazy var commentStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [commentWritingButton, totalListNumberLabel, tableView]))

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
        setupTotalListNumberLabel()
        setupCommentWritingButton()
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
        self.addSubview(commentStackView)
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            commentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            commentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        tableView.backgroundColor = .modalBackgroundBlue

    }

    private func setupTotalListNumberLabel() {
        switch entryPoint {
        case .visitorComment:
            totalListNumberLabel.text = "총 \(MockData.visitorComments.count)개"
        case .gatheringComment:
            totalListNumberLabel.text = "총 \(MockData.gatheringComments.count)개"
        }
    }

    private func setupCommentWritingButton() {
        switch entryPoint {
        case .visitorComment:
            commentWritingButton.setupButtonTitle(title: "방명록 작성")
        case .gatheringComment:
            commentWritingButton.setupButtonTitle(title: "댓글 작성")
        }
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
        guard let cell = tableView.dequeueReusableCell( withIdentifier: CommentTableViewCell.className, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        
        switch entryPoint {
        case .visitorComment:
            cell.bandNameLabel.text = MockData.visitorComments[indexPath.row].comment.author.band.name
            cell.commentTextLabel.text = MockData.visitorComments[indexPath.row].comment.content
            cell.commentDateLabel.text = MockData.visitorComments[indexPath.row].comment.createdAt.toString(format: DateFormatLiteral.standard)
        case .gatheringComment :
            cell.bandNameLabel.text = MockData.gatheringComments[indexPath.row].comment.author.band.name
            cell.commentTextLabel.text = MockData.gatheringComments[indexPath.row].comment.content
            cell.commentDateLabel.text = MockData.gatheringComments[indexPath.row].comment.createdAt.toString(format: DateFormatLiteral.standard)
        }
        return cell
    }
}
