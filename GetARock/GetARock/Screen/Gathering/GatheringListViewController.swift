//
//  GatheringListViewController.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/23.
//

import UIKit

enum GatheringType: CaseIterable {
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
    
    // MARK: - View
    
    private let segmentedControlButtons = ViewSwitchedSegmentedControl(buttonTitles: [GatheringType.gatheringCreated.toKorean(), GatheringType.gatheringJoined.toKorean()])

    private let gatheringListContentViewController: GatheringCreatedViewController = UIStoryboard(name: "GatheringView", bundle: nil).instantiateViewController(withIdentifier: GatheringCreatedViewController.className) as? GatheringCreatedViewController ?? GatheringCreatedViewController()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        segmentedControlButtons.viewSwitchedSegmentedControldelegate = self
    }

}

// MARK: - Layout

extension GatheringListViewController {
    private func attributes() {
        view.addSubview(segmentedControlButtons)
        view.addSubview(gatheringListContentViewController.view)
        view.backgroundColor = .modalBackgroundBlue
    }
    private func configureGatheringList() {
        gatheringListContentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gatheringListContentViewController.view.topAnchor.constraint(equalTo: segmentedControlButtons.bottomAnchor, constant: 3),
            gatheringListContentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gatheringListContentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gatheringListContentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

// MARK: - ViewSwitchedSegmentedControlDelegate

extension GatheringListViewController: ViewSwitchedSegmentedControlDelegate {
    func segmentValueChanged(to index: Int) {
        gatheringListContentViewController.gatheringType = GatheringType.allCases[index]
    }

}
