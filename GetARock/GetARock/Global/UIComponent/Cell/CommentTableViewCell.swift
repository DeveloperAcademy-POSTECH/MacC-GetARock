//
//  GusetBookTableViewCell.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - View

    private lazy var bandNameLabel: UILabel = {
        $0.text = "노엘천재"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    private lazy var moreButton: UIButton = {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())

    private lazy var commentTextLabel: UILabel = {
        $0.text = "노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())

    private lazy var commentDateLabel: UILabel = {
        $0.text = "2022.11.20"
        $0.textColor = .appColor(.lightGrey)
        $0.font = UIFont.systemFont(ofSize: 12)
        return $0
    }(UILabel())

    private lazy var commentInfoStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [bandNameLabel, moreButton]))

    private lazy var commentStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [commentInfoStack, commentTextLabel, commentDateLabel]))

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    private func setupLayout() {
        self.contentView.addSubview(commentStack)
        NSLayoutConstraint.activate([
            commentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            commentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            commentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
            commentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
}
