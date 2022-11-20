//
//  GusetBookTableViewCell.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var bandName: UILabel = {
        $0.text = "노엘천재"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    lazy var moreButton: UIButton = {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .white
//        $0.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        return $0
    }(UIButton())

    lazy var commentText: UILabel = {
        $0.text = "노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)노엘천재(본문)"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())

    lazy var commentDate: UILabel = {
        $0.text = "2022.11.20"
        $0.textColor = .appColor(.lightGrey)
        $0.font = UIFont.systemFont(ofSize: 12)
        return $0
    }(UILabel())

    lazy var commentInfo: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [bandName, moreButton]))

    lazy var comment: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [commentInfo, commentText, commentDate]))

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
        self.contentView.addSubview(comment)
        NSLayoutConstraint.activate([
            comment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            comment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            comment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
            comment.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
}
