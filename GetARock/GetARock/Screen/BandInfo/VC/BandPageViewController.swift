//
//  BandPageViewController.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/22.
//

import UIKit

class BandPageViewController: UIViewController {

    private let topView = TopViewOfInfoView(bandName: "블랙로즈", bandLocation: "주소다주소야주소다주소야")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

}

extension BandPageViewController {
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
    }
}
