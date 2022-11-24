//
//  SelectLocationViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/11/24.
//

import UIKit

protocol selectLocationDelegate {
    func setLocation(address: Location)
}

class SelectLocationViewController: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    
    var delegate: selectLocationDelegate?
    var textFieldText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressTextField.text = textFieldText
    }
    
    func attribute() {
        addressTextField.bounds.insetBy(dx: 4.0, dy: 4.0)
        addressTextField.backgroundColor = .backgroundBlue
        addressTextField.layer.cornerRadius = 12
        addressTextField.clipsToBounds = true
        addressTextField.layer.borderWidth = 1
        addressTextField.layer.borderColor = UIColor.white.cgColor
        addressTextField.placeholder = "  주소를 입력하세요"

    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let locationName = "장소명"
        if let delegate { // 추후 데이터 수정
            delegate.setLocation(
                address: Location(
                    name: locationName,
                    address: addressTextField.text,
                    additionalAddress: "",
                    coordinate: Coordinate(latitude: 36.01900, longitude: 129.34370)) // 포항시청
            )
        }
        navigationController?.popViewController(animated: true)
    }
}
