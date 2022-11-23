//
//  GusetBookTableViewCell.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - View

    let bandNameLabel: UILabel = {
        $0.text = "노엘천재"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    private let moreButton: UIButton = {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())

    let commentTextLabel: UILabel = {
        $0.text = "노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())

    let commentDateLabel: UILabel = {
        $0.text = "2022.11.20"
        $0.textColor = .lightGrey
        $0.font = UIFont.systemFont(ofSize: 12)
        return $0
    }(UILabel())

    private lazy var commentInfoStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [bandNameLabel, moreButton]))

    private lazy var commentStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [commentInfoStackView, commentTextLabel, commentDateLabel]))

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
        self.contentView.addSubview(commentStackView)
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            commentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            commentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
            commentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
}
