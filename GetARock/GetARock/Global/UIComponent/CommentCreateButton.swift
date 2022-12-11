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

    let titleButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "buttonBackground"), for: .normal)
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
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        guard let superView = superview else { return }
        NSLayoutConstraint.activate([
            superView.centerXAnchor.constraint(equalTo: centerXAnchor),
            superView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupLayout() {
        self.addSubview(titleButton)
        titleButton.invalidateIntrinsicContentSize()
        NSLayoutConstraint.activate([
            titleButton.topAnchor.constraint(equalTo: self.topAnchor),
            titleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleButton.heightAnchor.constraint(equalToConstant: Size.height)
        ])
    }
    func setupButtonTitle(title: String) {
        titleButton.setTitle(title, for: .normal)
    }
}
