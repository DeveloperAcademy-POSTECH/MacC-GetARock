//
//  GatheringInfoViewController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/21.
//

import UIKit

class GatheringInfoViewController: UIViewController, Reportable {
    
    // MARK: - properties
    
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var gatheringTitleLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var gatheringDateLabel: UILabel!
    @IBOutlet weak var gatheringLocationLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var ellipsisButton: UIButton!
    
    @IBOutlet weak var commentsView: UIView!
    var gatheringInfo: GatheringInfo = MockData.gatherings[3]
    var gatheringCommentsList = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CommentListView(entryPoint: .gatheringComment))
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        gatheringCommentsList.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionView.layer.cornerRadius = 15
        conditionView.layer.borderWidth = 2
        conditionView.layer.borderColor = UIColor.white.cgColor
        connectWithData()
        setupLayout()
        view.backgroundColor = .modalBackgroundBlue
    }
    
    // MARK: - Method
    
    private func setupLayout() {
        commentsView.addSubview(gatheringCommentsList)
        gatheringCommentsList.tableView.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            gatheringCommentsList.topAnchor.constraint(equalTo: commentsView.topAnchor, constant: 20),
            gatheringCommentsList.leadingAnchor.constraint(equalTo: commentsView.leadingAnchor, constant: 16),
            gatheringCommentsList.trailingAnchor.constraint(equalTo: commentsView.trailingAnchor, constant: -16),
            gatheringCommentsList.bottomAnchor.constraint(equalTo: commentsView.bottomAnchor)
        ])
        setupWritingButton()
        
    }
    
    func connectWithData() {
        gatheringTitleLabel.text = gatheringInfo.gathering.title
        bandNameLabel.text = gatheringInfo.gathering.host.band.name
        gatheringDateLabel.text = gatheringInfo.gathering.date.toString(format: DateFormatLiteral.standard )
        gatheringLocationLabel.text = gatheringInfo.gathering.location.address
        describtionLabel.text = gatheringInfo.gathering.introduction
    }
    
    func alertActionButtonPressed() {
        print("삭제에 성공했습니다.")
    }
    
    @IBAction func touchUpInsideEllipsis(_ sender: UIButton) {
        showActionSheet()
    }
    
    private func setupWritingButton() {
        gatheringCommentsList.commentWritingButton.titleButton.addTarget(self, action: #selector(didTapVisitorCommentButton), for: .touchUpInside)
    }

    @objc func didTapVisitorCommentButton() {
        let popupViewController = CommentWritingPopupViewController(entryPoint: .gatheringComment)
        popupViewController.modalPresentationStyle = .fullScreen
        self.present(popupViewController, animated: false)
    }
}
