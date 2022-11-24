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

    // MARK: - Properties
    
    var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers([viewControllerList[self.currentPage]],
                                                       direction: direction, animated: true)
        }
    }
    
    private var bandinfo: BandInfo = MockData.bands[0]
    
    init(bandInfo: BandInfo) {
        super.init(nibName: nil, bundle: nil)
        self.bandinfo = bandInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View

    private lazy var topView = TopViewOfInfoView(bandName: self.bandinfo.band.name,
                                                 bandLocation: self.bandinfo.band.location.address ?? "")
    private let segmentedControlButtons = ViewSwitchedSegmentedControl(buttonTitles:
                                                                        [BandInfoViewList.bandInfo.toKorean(),
                                                                         BandInfoViewList.bandTimeLine.toKorean(),
                                                                         BandInfoViewList.visitorComment.toKorean()])
    private lazy var bandInfoViewController = UIStoryboard(name: "BandInfo", bundle: nil).instantiateViewController(withIdentifier: BandInfoViewController.className)
    private lazy var bandTimelineViewController = UIStoryboard(name: "BandTimeline", bundle: nil).instantiateViewController(withIdentifier: BandTimelineViewController.className)
    private lazy var commentListViewController = VisitorCommentViewController()
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.setViewControllers([self.viewControllerList[0]], direction: .forward, animated: true)
        return pageViewController
    }()
    
    var viewControllerList: [UIViewController] {
        [self.bandInfoViewController, self.bandTimelineViewController, self.commentListViewController]
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        segmentedControlButtons.delegate = self
    }

}

// MARK: - Layout

extension BandPageViewController {
    
    private func configurePageViewController() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControlButtons.bottomAnchor, constant: 3),
            pageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
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
        configurePageViewController()
    }
    
}

// MARK: - ViewSwitchedSegmentedControlDelegate

extension BandPageViewController: ViewSwitchedSegmentedControlDelegate {
    func segmentValueChanged(to index: Int) {
        currentPage = index
    }
    
}
