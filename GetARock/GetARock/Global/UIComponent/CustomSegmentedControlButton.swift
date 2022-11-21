//
//  CustomSegmentedControlButton.swift
//  GetARock
//
//  Created by Somin Park on 2022/11/20.
//

import UIKit

final class CustomSegmentedControlButton: UIView {
    private var buttonTitles = [String]()
    private var buttons = [UIButton]()
    private var selectorView: UIView = {
        let view = UIView()
        return view
    }()
    private var staticLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.dividerBlue)
        return view
    }()
    let textColor: UIColor = .white
    let selectedColor: UIColor = .appColor(.mainPurple)
    
    convenience init(buttonTitles: [String]) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    private func updateView() {
        createButton()
        setupLayout()
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControlButton.buttonAction(sender:)),
                             for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectedColor, for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                let selectorPosition = frame.width / CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.2) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                button.setTitleColor(selectedColor, for: .normal)
            }
        }
    }
    
}

extension CustomSegmentedControlButton {
    private func setupLayout() {
        configStaticLineView()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 3))
        selectorView.backgroundColor = selectedColor
        addSubview(selectorView)
    }
    
    private func configStaticLineView() {
        staticLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(staticLineView)
        NSLayoutConstraint.activate([
            staticLineView.topAnchor.constraint(equalTo: self.bottomAnchor),
            staticLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            staticLineView.heightAnchor.constraint(equalToConstant: 1),
            staticLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            staticLineView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
