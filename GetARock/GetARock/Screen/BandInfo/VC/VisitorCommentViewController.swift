//
//  VisitorCommentViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

final class VisitorCommentViewController: UIViewController {

    // MARK: - View

    private let visitorCommentList = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(commentMode: .visitorComment))
    
    var cellIndex: IndexPath = []

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
        view.addSubview(visitorCommentList)
        visitorCommentList.delegate = self
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
        let popupViewController = CommentWritingPopupViewController(commentMode: .visitorComment)
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
        popupViewController.delegate = self
    }
}

// MARK: - CommentListUpdateDelegate

extension VisitorCommentViewController: CommentListUpdateDelegate {
    
    func refreshCommentList() {
        visitorCommentList.tableView.reloadData()
        visitorCommentList.setupTotalListNumberLabel()
    }
}

// MARK: - CheckCellIndexDelegate, Reportable

extension VisitorCommentViewController: CheckCellIndexDelegate, Reportable {
    
    func checkCellIndex(indexPath: IndexPath) {
        cellIndex = indexPath
        print("\(indexPath) 번 셀의 액션시트 노출")
        showActionSheet()
    }

    func alertActionButtonPressed() {
        MockData.visitorComments.remove(at: cellIndex.row)
        visitorCommentList.tableView.reloadData()
    }

}
