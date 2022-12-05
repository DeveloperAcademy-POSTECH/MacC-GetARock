//
//  VisitorCommentViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

final class VisitorCommentViewController: UIViewController {

    // MARK: - View
    
    private let commentListView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(entryPoint: .visitorComment))

    // MARK: - Property
    
    var bandAPI = BandAPI()
    var bandInfo: BandInfo? {
        didSet {
            Task {
                guard let comments = try? await getComments() else { print(22); return }
                self.comments = comments
            }
        }
    }
    var comments: [VisitorCommentInfo] = [] {
        didSet {
            MockData.visitorComments = comments
            commentListView.tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        commentListView.tableView.reloadData()
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
        view.addSubview(commentListView)
        NSLayoutConstraint.activate([
            commentListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            commentListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            commentListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            commentListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupWritingButton()
        
    }

    private func setupWritingButton() {
        commentListView.commentWritingButton.titleButton.addTarget(self, action: #selector(didTapVisitorCommentButton), for: .touchUpInside)
    }

    @objc func didTapVisitorCommentButton() {
        let popupViewController = CommentWritingPopupViewController(entryPoint: .visitorComment)
        popupViewController.bandInfo = bandInfo
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
    
    private func getComments() async throws -> [VisitorCommentInfo] {
        guard let bandID = bandInfo?.bandID else { return [] }
        return try await bandAPI.getComments(of: bandID)
    }
}
