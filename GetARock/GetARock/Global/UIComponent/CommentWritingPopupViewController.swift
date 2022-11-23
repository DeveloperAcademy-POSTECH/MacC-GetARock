//
//  TestViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit

class CommentWritingPopupViewController: UIViewController {

    let textViewPlaceHolder = "텍스트를 입력해주세요"

    // MARK: - View

    lazy var popupTitleLabel: UILabel = {
        $0.text = "방명록 작성"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
        return $0
    }(UILabel())

    lazy var closeButton: UIButton = {
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

    lazy var confirmButton: CommentCreateButton = {
        $0.setupButtonTitle(title: "작성 완료")
        return $0
    }(CommentCreateButton())

    lazy var popUpHeader: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [popupTitleLabel, closeButton]))

    lazy var popup: UIStackView = {
        $0.layoutMargins = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        $0.spacing = 15
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [popUpHeader, commentTextView, confirmButton]))

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupLayout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }

    private func setupLayout() {
        view.addSubview(popup)
        popup.backgroundColor = .modalBackgroundBlue
        NSLayoutConstraint.activate([
            popup.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popup.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popup.widthAnchor.constraint(equalToConstant: CommentCreateButton.Size.width),
            popup.heightAnchor.constraint(equalToConstant: 300)
        ])
        setupCloseButton()
    }

    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(self.dismissPopup), for: .touchUpInside)
    }

    @objc private func addNewComment(_ sender: Any) {
           // TO-Do : 텍스트 필드에 입력한 텍스트 방명록 리스트에 추가
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
