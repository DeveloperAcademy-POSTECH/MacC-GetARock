//
//  EmptyListView.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/20.
//

import UIKit

class EmptyListView: UIView {

    // MARK: - Property

    private lazy var defaultTextLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

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
    }

    private func setupLayout() {
        self.addSubview(defaultTextLabel)
        NSLayoutConstraint.activate([
            defaultTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            defaultTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
