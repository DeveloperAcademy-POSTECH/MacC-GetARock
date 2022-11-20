//
//  AddGatheringViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/11/21.
//

import UIKit

class AddGatheringViewController: UIViewController {

    // MARK: - View

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var hostBandNameLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!

    private let placeHolderLabel: UILabel = {
        $0.text = "내용을 입력하세요"
        $0.textColor = .appColor(.lightGrey)
        $0.sizeToFit()
        $0.font = .preferredFont(forTextStyle: .subheadline)
        return $0
    }(UILabel())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        setupLayout()
    }

    // MARK: - Method

    private func attribute() {
        hostBandNameLabel.text = "블랙로즈" // 추후 유저디폴트 사용 예정
        titleTextField.becomeFirstResponder()
    }

    private func setupLayout() {
        view.addSubview(placeHolderLabel)
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: aboutTextView.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: aboutTextView.leadingAnchor, constant: 4)
        ])
        aboutTextView.delegate = self
    }
    
}

// MARK: - UICollectionViewDelegate

extension AddGatheringViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.textColor = aboutTextView.text.count == 0 ? .appColor(.lightGrey) : .clear
    }
}
