//
//  GatheringListTapViewController.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/23.
//

import UIKit

enum GatheringListType: CaseIterable {
    case createdGathering
    case joinedGathering
    
    func toKorean() -> String {
        switch self {
        case .createdGathering: return "내가 만든 모여락"
        case .joinedGathering: return "댓글 단 모여락"
        }
    }
}

class GatheringListTapViewController: UIViewController {
    
    // MARK: - View
    
    private let segmentedControlButtons = ViewSwitchedSegmentedControl(
        buttonTitles: [
            GatheringListType.createdGathering.toKorean(),
            GatheringListType.joinedGathering.toKorean()
        ])
    let gatheringListContentViewController: GatheringListViewController = UIStoryboard(name: "GatheringList",
        bundle: nil
    ).instantiateViewController(
        withIdentifier: GatheringListViewController.className
    ) as? GatheringListViewController ?? GatheringListViewController()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

}

// MARK: - Layout

extension GatheringListTapViewController {
    private func setupLayout() {
        attributes()
        configureButton()
        configureGatheringList()
    }
    private func attributes() {
        view.addSubview(segmentedControlButtons)
        view.addSubview(gatheringListContentViewController.view)
        view.backgroundColor = .modalBackgroundBlue
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
    private func configureGatheringList() {
        gatheringListContentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gatheringListContentViewController.view.topAnchor.constraint(equalTo: segmentedControlButtons.bottomAnchor, constant: 3),
            gatheringListContentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gatheringListContentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gatheringListContentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
