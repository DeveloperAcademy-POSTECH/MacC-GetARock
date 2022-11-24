//
//  VisitorCommentViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

final class VisitorCommentViewController: UIViewController{
    
    var bandData : BandInfo?
    var visitorCommentInfo: [VisitorCommentInfo]?
    
    // MARK: - View

    private let visitorCommentList = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(entryPoint: .visitorComment, visitorCommentInfo: <#T##[VisitorCommentInfo]#>))

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        visitorCommentList.tableView.reloadData()
    }

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
        view.addSubview(visitorCommentList)
        NSLayoutConstraint.activate([
            visitorCommentList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            visitorCommentList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            visitorCommentList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            visitorCommentList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupWritingButton()
        
    }

    private func setupWritingButton() {
        visitorCommentList.commentWritingButton.titleButton.addTarget(self, action: #selector(didTapVisitorCommentButton), for: .touchUpInside)
    }

    @objc func didTapVisitorCommentButton() {
        let popupViewController = CommentWritingPopupViewController(entryPoint: <#T##CommentListEntryPoint#>)
        popupViewController.entryPoint = visitorCommentList.entryPoint
        popupViewController.bandInfo = bandData
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
}
