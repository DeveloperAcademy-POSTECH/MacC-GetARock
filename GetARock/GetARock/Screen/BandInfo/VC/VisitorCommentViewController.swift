//
//  VisitorCommentViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

final class VisitorCommentViewController: UIViewController {

    // MARK: - View

    private let visitorCommentButton: CommentCreateButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setupButtonTitle(title: "방명록 남기기")
        return $0
    }(CommentCreateButton())

    private let visitorCommentList = CommentListView(entryPoint: .visitorComment)

    private lazy var commentStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [visitorCommentButton, visitorCommentList]))

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupLayout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .modalBackgroundBlue
    }

    private func setupLayout() {
        view.addSubview(commentStackView)
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            commentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            commentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            commentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupWritingButton()
    }

    private func setupWritingButton() {
        let tapWritingButtonGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapVisitorCommentButton)
        )
        visitorCommentButton.addGestureRecognizer(tapWritingButtonGesture)
    }
    
    @objc func didTapVisitorCommentButton() {
        let popupViewController = CommentWritingPopupViewController()
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
}
