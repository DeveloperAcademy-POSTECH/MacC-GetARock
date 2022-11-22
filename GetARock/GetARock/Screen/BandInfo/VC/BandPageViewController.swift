//
//  BandPageViewController.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/22.
//

import UIKit

enum BandInfoViewList: Int, CaseIterable {
    case bandInfo
    case bandTimeLine
    case visitorComment

    func toKorean() -> String {
        switch self {
        case .bandInfo: return "밴드 정보"
        case .bandTimeLine: return "타임라인"
        case .visitorComment: return "방명록"
        }
    }
}

class BandPageViewController: UIViewController {

    // MARK: - View

    private let topView = TopViewOfInfoView(bandName: "블랙로즈", bandLocation: "주소다주소야주소다주소야")
    private let segmentedControlButtons = ViewSwitchedSegmentedControl(buttonTitles:
                                                                        [BandInfoViewList.bandInfo.toKorean(),
                                                                         BandInfoViewList.bandTimeLine.toKorean(),
                                                                         BandInfoViewList.visitorComment.toKorean()])

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

}

// MARK: - Layout

extension BandPageViewController {
    private func configureSegmentedControlButton() {
        segmentedControlButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControlButtons)
        NSLayoutConstraint.activate([
            segmentedControlButtons.topAnchor.constraint(equalTo: topView.bottomAnchor),
            segmentedControlButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControlButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControlButtons.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func configureTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    private func setupLayout() {
        view.backgroundColor = .modalBackgroundBlue
        configureTopView()
        configureSegmentedControlButton()
    }
}
