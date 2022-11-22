//
//  CommentCreateButton.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/20.
//

import UIKit

class CommentCreateButton: UIView {

    // MARK: - Property

    enum Size {
        static let spacing: CGFloat = 16.0
        static let height: CGFloat = 50.0
        static let width: CGFloat = UIScreen.main.bounds.size.width - Size.spacing * 2
    }

    // MARK: - View

    lazy var buttonTitle: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Method

    private func attribute() {
        self.backgroundColor = .mainPurple
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: Size.width),
            self.heightAnchor.constraint(equalToConstant: Size.height)
        ])
    }

    private func setupLayout() {
        self.addSubview(buttonTitle)
        NSLayoutConstraint.activate([
            buttonTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func setupButtonTitle(title: String) {
        buttonTitle.setTitle(title, for: .normal)
    }
}
