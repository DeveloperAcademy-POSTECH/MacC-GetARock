//
//  GusetBookTableViewCell.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class GusetBookTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var bandName: UILabel = {
        $0.text = "노엘천재"
        $0.textColor = .systemPink
        $0.backgroundColor = .red
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var moreButton: UIButton = {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = UIColor.white
        $0.backgroundColor = .green
//        $0.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var comment: UILabel = {
        $0.text = "노엘천재(본문)"
        $0.textColor = .systemPink
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    lazy var commentDate: UILabel = {
        $0.text = "2022.11.20"
        $0.textColor = .appColor(.lightGrey)
        $0.font = UIFont.systemFont(ofSize: 12)
        return $0
    }(UILabel())
    
    lazy var headerArea: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [bandName, moreButton]))
    
    lazy var commentArea: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [headerArea, comment, commentDate]))
    
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
        
        self.contentView.addSubview(commentArea)
        NSLayoutConstraint.activate([
            commentArea.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            commentArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
}
