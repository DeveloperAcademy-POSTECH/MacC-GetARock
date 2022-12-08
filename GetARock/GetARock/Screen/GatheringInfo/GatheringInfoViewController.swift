//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

final class GatheringInfoViewController: UIViewController {
    
    // MARK: - properties
    
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var gatheringTitleLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var gatheringDateLabel: UILabel!
    @IBOutlet weak var gatheringLocationLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var ellipsisButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var commentsView: UIView!
    var gatheringInfo: GatheringInfo = {
        MockData.gatherings[3]
    }() {
        didSet {
            didViewLoad ? connectWithData() : Void()
            if didViewLoad {
                setComments()
            }
        }
    }
    var comments: [GatheringCommentInfo] = [] {
        didSet {
            MockData.gatheringComments = comments
            gatheringCommentsListView.didCommentChanged()
        }
    }
    var didViewLoad: Bool = false
    var gatheringCommentsListView = {
        MockData.gatheringComments = []
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(entryPoint: .gatheringComment))
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        gatheringCommentsListView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didViewLoad = true
        setComments()
        setConditionView()
        connectWithData()
        setupLayout()
        view.backgroundColor = .modalBackgroundBlue
    }
    
    // MARK: - Method
    
    private func setConditionView() {
        
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.fillMainGradient()
        
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
    
    func connectWithData() {
        gatheringTitleLabel.text = gatheringInfo.gathering.title
        bandNameLabel.text = gatheringInfo.gathering.host.band.name
        gatheringDateLabel.text = gatheringInfo.gathering.date.toString(format: DateFormatLiteral.standard )
        gatheringLocationLabel.text = gatheringInfo.gathering.location.address
        describtionLabel.text = gatheringInfo.gathering.introduction
        statusLabel.text = gatheringInfo.gathering.status.toKorean()
    }
    
    @IBAction func touchUpInsideEllipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
    private func setupWritingButton() {
        gatheringCommentsListView.commentWritingButton.titleButton.addTarget(self, action: #selector(didTapGatheringCommentButton), for: .touchUpInside)
    }

    @objc func didTapGatheringCommentButton() {
        let popupViewController = CommentWritingPopupViewController(entryPoint: .gatheringComment)
        popupViewController.gatheringInfo = gatheringInfo
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = .fullScreen
        self.present(popupViewController, animated: false)
    }
    
    private func setComments() {
        Task {
            try? await gatheringCommentsListView.gatheringComments = getComments()
        }
    }
    
    private func getComments() async throws -> [GatheringCommentInfo] {
        let gatheringAPI = GatheringAPI()
        return try await gatheringAPI.getComments(of: gatheringInfo.gatheringID)
    }
}

// MARK: - extension Reportable Method

extension GatheringInfoViewController: Reportable {
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
}

extension GatheringInfoViewController: WritingCommentPopupViewControllerDelegate {
    func didWriteComment() {
        Task {
            self.comments = try await self.getComments()
        }
    }
}
