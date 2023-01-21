//
//  AddGatheringViewController+ScrollAdaptToKeyboard.swift
//  GetARock
//
//  Created by Hyorim Nam on 2023/01/16.
//

import UIKit

// MARK: - Scroll Adaptation for Keyboard Show

extension AddGatheringViewController {
    func addObeserversForKeyboardShow() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(adaptScrollViewToKeyboardShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(adaptScrollViewToKeyboardHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeObserversForKeyboardShow() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func adaptScrollViewToKeyboardShow(_ sender: Notification) {
        guard let userInfo: NSDictionary = sender.userInfo as NSDictionary?,
              let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
                  return
              }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func adaptScrollViewToKeyboardHide(_ sender: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
