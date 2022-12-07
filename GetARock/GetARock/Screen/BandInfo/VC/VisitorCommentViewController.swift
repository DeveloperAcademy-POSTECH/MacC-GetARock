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
    func showEditActionSheet(indexPath: IndexPath) {
        let indexPath = indexPath
        print(indexPath)
        showActionSheet()
    }

    func alertActionButtonPressed() {
        print("삭제하기")
//        MockData.visitorComments.remove(at: indexPath.row)
//        let indexPath = IndexPath(item: 0, section: 0)
//        visitorCommentList.tableView.deleteRows(at: [indexPath], with: .fade)
        
        visitorCommentList.tableView.reloadData()
    }
}

// MARK: - Reportable

