//
//  TestViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

class CommentWritingPopupViewController: UIViewController {
    
    // MARK: - Properties
    var entryPoint: CommentListEntryPoint = .visitorComment
    var bandInfo: BandInfo?
    var gatheringInfo: GatheringInfo?
    private let textViewPlaceHolder = "텍스트를 입력해주세요"
    
    init(entryPoint: CommentListEntryPoint, bandInfo: BandInfo? = nil) {
        self.entryPoint = entryPoint
        self.author = bandInfo?.band.name
        self.gatheringInfo = nil
    }
    
    init(entryPoint: CommentListEntryPoint, gatheringInfo: GatheringInfo? = nil) {
        self.entryPoint = entryPoint
        self.bandInfo = nil
        self.gatheringInfo = gatheringInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View
    
    private let popupTitleLabel: UILabel = {
        $0.text = "방명록 작성"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let closeButton: UIButton = {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())
    
    lazy var commentTextView: UITextView = {
        $0.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        $0.backgroundColor = .backgroundBlue
        $0.font = UIFont.systemFont(ofSize: 14.0)
        $0.textColor = UIColor.black
        $0.textAlignment = NSTextAlignment.left
        $0.dataDetectorTypes = UIDataDetectorTypes.all
        $0.text = textViewPlaceHolder
        $0.textColor = .lightGray
        $0.delegate = self
        return $0
    }(UITextView())
    
    private let confirmButton: CommentCreateButton = {
        $0.setupButtonTitle(title: "작성 완료")
        return $0
    }(CommentCreateButton())
    
    private lazy var popUpHeaderStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [popupTitleLabel, closeButton]))
    
    private lazy var popupStackView: UIStackView = {
        $0.layoutMargins = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        $0.spacing = 15
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
        
    }(UIStackView(arrangedSubviews: [popUpHeaderStackView, commentTextView, confirmButton]))
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupLayout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        setupPopupTitleLabel()
    }
    
    private func setupLayout() {
        view.addSubview(popupStackView)
        popupStackView.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            popupStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupStackView.widthAnchor.constraint(equalToConstant: CommentCreateButton.Size.width),
            popupStackView.heightAnchor.constraint(equalToConstant: 300)
        ])
        setupCloseButton()
    }
    
    private func setupPopupTitleLabel() {
        switch entryPoint {
        case .visitorComment:
            popupTitleLabel.text = "방명록 작성"
        case .gatheringComment:
            popupTitleLabel.text = "댓글 작성"
        }
    }
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(self.dismissPopup), for: .touchUpInside)
    }
    
    private func setupConfirmButton() {
        confirmButton.titleButton.addTarget(self, action: #selector(self.addNewComment(_:)), for: .touchUpInside)
    }
    
    
    @objc private func addNewComment(_ sender: Any) {
       
        switch entryPoint {
        case .visitorComment:
            guard let bandInfo = bandInfo else { return }
            if let text = commentTextView.text {
                let saveData = VisitorCommentInfo(
                    commentID: "visitorCommentID-005",
                    comment: VisitorComment(
                        hostBand: bandInfo,
                        author: bandInfo.band.name,
                        content: text,
                        createdAt: Date()
                    )
                )
                MockData.visitorComments.append(saveData)
            }
        case .gatheringComment:
            guard let gatheringInfo = gatheringInfo else { return }
            if let text = commentTextView.text {
                if let text = commentTextView.text {
                    let saveData = GatheringCommentInfo(
                        commentID: "gatheringID-005",
                        comment: GatheringComment(
                            gathering: gatheringInfo,
                            author: MockData.gatheringComments[0].comment.author,
                            content: text,
                            createdAt: Date()))
                    MockData.gatheringComments.append(saveData)
                }
            }
        }
    }
    
    @objc private func dismissPopup(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension CommentWritingPopupViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .white
        }
    }
}

