//
//  MainTabBarController.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/07.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    enum Mode {
        case individual
        case team
        
        var recomendedTitle: String {
            switch self {
            case .individual: return "밴드 추천"
            case .team: return "멤버 추천"
            }
        }
    }

    // MARK: - Property
    var mode: Mode = .individual
    
    // MARK: - View
    lazy var recomendedListViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .orange
        viewController.tabBarItem = UITabBarItem(title: mode.recomendedTitle,
                                                 image: UIImage(systemName: "list.bullet"),
                                                 tag: 0)
        return viewController
    }()
    let myPageViewController: MyPageViewController = {
        let viewController = MyPageViewController()
        viewController.view.backgroundColor = .yellow
        viewController.tabBarItem = UITabBarItem(title: "마이페이지",
                                                 image: UIImage(systemName: "person"),
                                                 tag: 1)
        return viewController
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    // MARK: - Method
    func setTabBar() {
        setAppearance()
        setViewControllers([recomendedListViewController, myPageViewController],
                           animated: false)
    }
    
    func setAppearance() {
        // TODO: color 값 업데이트 되면 색상 세팅 다시하기
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemPurple
        tabBar.unselectedItemTintColor = .lightGray
        
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.backgroundColor = .darkGray
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemPurple]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray3]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray3
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemPurple

        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
}

// MARK: - use Canvas
#if DEBUG
import SwiftUI

struct MainTabBarControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainTabBarController

    func makeUIViewController(context: Context) -> MainTabBarController {
        return MainTabBarController()
    }

    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {

    }

}

@available(iOS 13.0.0, *)
struct MainTabBarControllerViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabBarControllerRepresentable()
                .previewDevice("iPhone 11 Pro")
        }
    }
}
#endif
