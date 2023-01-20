//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2023/01/05.
//

import UIKit

final class GatheringInfoViewController: UIViewController {
    
    // MARK: - properties
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ellipsisButton: UIButton!
    @IBOutlet weak var gatheringTitleLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var gatheringDateLabel: UILabel!
    @IBOutlet weak var gatheringLocationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsView: UIView!
    
    private var gatheringCommentsListView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(commentMode: .gatheringComment))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gatheringCommentsListView.tableView.reloadData()
        refreshCommentList()
    }
    
    // MARK: - Method
    
    @IBAction func touchUpInsideEllipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
    private func setupLayout() {
        commentsView.addSubview(gatheringCommentsListView)
        gatheringCommentsListView.tableView.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            gatheringCommentsListView.topAnchor.constraint(equalTo: commentsView.topAnchor, constant: 20),
            gatheringCommentsListView.leadingAnchor.constraint(equalTo: commentsView.leadingAnchor, constant: 16),
            gatheringCommentsListView.trailingAnchor.constraint(equalTo: commentsView.trailingAnchor, constant: -16),
            gatheringCommentsListView.bottomAnchor.constraint(equalTo: commentsView.bottomAnchor)
        ])
        setupWritingButton()
    }
    
    private func setupWritingButton() {
        gatheringCommentsListView.commentWritingButton.titleButton.addTarget(self, action: #selector(didTapGatheringCommentButton), for: .touchUpInside)
    }
    
}

// MARK: - extension Reportable Method

extension GatheringInfoViewController: Reportable {
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
}

// MARK: - extension CommentListUpdate deledgate
extension GatheringInfoViewController: CommentListUpdateDelegate {
    func refreshCommentList() {
        gatheringCommentsListView.setupTotalListNumberLabel()
        commentsView.heightAnchor.constraint(equalToConstant: CGFloat(MockData.gatheringComments.count * 170)).isActive = true
    }
    
    @objc func didTapGatheringCommentButton() {
        let popupViewController = CommentWritingPopupViewController(commentMode: .gatheringComment)
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
}
