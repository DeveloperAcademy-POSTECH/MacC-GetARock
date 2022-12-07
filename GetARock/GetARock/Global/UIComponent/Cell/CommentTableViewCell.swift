//
//  GusetBookTableViewCell.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: NotifyTapMoreButtonDelegate?
    
    // MARK: - View

    let bandNameLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    let moreButton: UIButton = {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())

    let commentTextLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())

    let commentDateLabel: UILabel = {
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
        setupMoreButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    private func setupLayout() {
        self.contentView.addSubview(commentStackView)
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            commentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupMoreButton() {
        moreButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
    }
    
    @objc func showActionSheet() {
        self.delegate?.tapcommentListMoreButton(cell: self)
        // 눌린 셀은 그 자체임으로 self를 전달하면됨
        print("눌림")
    }
}

// MARK: - NotifyTapMoreButtonDelegate

protocol NotifyTapMoreButtonDelegate: AnyObject {
    func tapcommentListMoreButton(cell: UITableViewCell)
    // 저번에 셀삭 제를 구현햇을 때, 테이블뷰 편집모드에서 작업해서 테이블뷰기 해당 셀의 indexPath를 알고 있었지만
    // 이번에는 편집 모드에서 구현할게 아니고, 다 같은 셀 모양을 가지고 있기때문에 테이블뷰는 어느 셀이 눌렷는지 모름
    // 그래서 눌린 셀을 전달해서 해당 셀의 indexPath를 확인할 수 있도록 해줘야함
}
