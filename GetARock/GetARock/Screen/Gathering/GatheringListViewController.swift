//
//  GatheringListViewController.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/23.
//

import UIKit

enum GatheringCategory: Int, CaseIterable {
    case gatheringCreated
    case gatheringJoined
    
    func toKorean() -> String {
        switch self {
        case .gatheringCreated: return "내가 만든 모여락"
        case .gatheringJoined: return "댓글 단 모여락"
        }
    }
}

class GatheringListViewController: UIViewController {

    private let segmentedControlButtons = ViewSwitchedSegmentedControl(buttonTitles: [GatheringCategory.gatheringCreated.toKorean(), GatheringCategory.gatheringJoined.toKorean()])
    
    private let gatheringListViewController = UIStoryboard(name: "GatheringView", bundle: nil).instantiateViewController(withIdentifier: GatheringCreatedViewController.className)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

}

extension GatheringListViewController {
    private func attributes() {
        view.addSubview(segmentedControlButtons)
        view.addSubview(gatheringListViewController.view)
        view.backgroundColor = .modalBackgroundBlue
    }
    private func configureGatheringList() {
        gatheringListViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gatheringListViewController.view.topAnchor.constraint(equalTo: segmentedControlButtons.bottomAnchor, constant: 3),
            gatheringListViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gatheringListViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gatheringListViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func configureButton() {
        segmentedControlButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControlButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            segmentedControlButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControlButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControlButtons.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setupLayout() {
        attributes()
        configureButton()
        configureGatheringList()
    }
}

extension GatheringListViewController: ViewSwitchedSegmentedControlDelegate {
    func segmentValueChanged(to index: Int) {
        gatheringListContentViewController.gatheringType = GatheringType.allCases[index]
    }

}
