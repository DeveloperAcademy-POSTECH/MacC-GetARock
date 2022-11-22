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
    @IBOutlet weak var scrollView: UIScrollView!

    private let placeHolderLabel: UILabel = {
        $0.text = "내용을 입력하세요"
        $0.textColor = .lightGray
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

    @IBAction func scrollViewTapRecognizer(_ sender: UITapGestureRecognizer) {
        titleTextField.endEditing(true)
        aboutTextView.endEditing(true)
    }

    private func attribute() {
        setupNavigationBar()
        hostBandNameLabel.text = "블랙로즈" // 추후 유저디폴트 사용 예정
        titleTextField.becomeFirstResponder()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
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

// MARK: - UITextViewDelegate

extension AddGatheringViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.textColor = aboutTextView.text.count == 0 ? .lightGray : .clear
    }
}
