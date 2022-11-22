//
//  VisitorCommentViewController.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/22.
//

import UIKit



class VisitorCommentViewController: UIViewController {
    // MARK: - View
    private let visitorCommentButton: CommentCreateButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setupButtonTitle(title: "방명록 남기기")
        return $0
    }(CommentCreateButton())
    
    private let visitorCommentList = CommentListView()
    
    private lazy var comment: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [visitorCommentButton, visitorCommentList]))

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
        view.addSubview(comment)
        NSLayoutConstraint.activate([
            comment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            comment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            comment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            comment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupButton()
    }
    
    private func setupButton() {
        let tapWritingButtonGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapVisitorCommentButton)
        )
        visitorCommentButton.addGestureRecognizer(tapWritingButtonGesture)
    }
    
    @objc func didTapVisitorCommentButton() {
        let popupViewController = CommentWritingPopupViewController()
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
}

//extension VisitorCommentViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
//            self.categories.remove(at: indexPath.section)
//            let indexSet = IndexSet(arrayLiteral: indexPath.section)
//            self.tableView.deleteSections(indexSet, with: .automatic )
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
//        return swipeActions
//    }
//}
