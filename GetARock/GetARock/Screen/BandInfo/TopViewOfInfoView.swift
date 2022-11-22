//
//  TopViewOfInfoView.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/22.
//

import UIKit

final class TopViewOfInfoView: UIView {
    
    // MARK: - Properties
    
    private var bandNameLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private var bandLocationLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private var divider: UIView = {
        $0.backgroundColor = .backgroundBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    convenience init(bandName: String, bandLocation: String) {
        self.init(frame: .zero)
        self.bandNameLabel.text = bandName
        self.bandLocationLabel.text = bandLocation
        attribute()
        setupLayout()
    }

}

// MARK: - Layout

extension TopViewOfInfoView {
    private func attribute() {
        addSubview(bandNameLabel)
        addSubview(bandLocationLabel)
        addSubview(divider)
    }
    private func configureBandNameLabel() {
        NSLayoutConstraint.activate([
            bandNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            bandNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
    private func configureBandLocationLabel() {
        NSLayoutConstraint.activate([
            bandLocationLabel.topAnchor.constraint(equalTo: bandNameLabel.bottomAnchor, constant: 10),
            bandLocationLabel.leadingAnchor.constraint(equalTo: bandNameLabel.leadingAnchor)
        ])
    }
    private func configureDividedLine() {
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: bandLocationLabel.bottomAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    private func setupLayout() {
        configureBandNameLabel()
        configureBandLocationLabel()
        configureDividedLine()
    }
}
