//
//  MainTabBarController.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/07.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Property
    
    // MARK: - View
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Method

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
