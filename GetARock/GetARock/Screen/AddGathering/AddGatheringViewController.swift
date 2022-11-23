//
//  AddGatheringViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/11/21.
//

import UIKit

class AddGatheringViewController: UIViewController {

    // MARK: - Property

    private var hostBandName: String?
    private var gatheringLocation: Location?

    // MARK: - View

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var hostBandNameLabel: UILabel!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!

    private let placeHolderLabel: UILabel = {
        $0.text = "내용을 입력하세요"
        $0.textColor = .lightGray
        $0.sizeToFit()
        $0.font = .preferredFont(forTextStyle: .subheadline)
        return $0
    }(UILabel())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        setDelegate()
        setupLayout()
        setAddGatheringTestData() // 테스트용, 추후 삭제
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Method

    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        if introductionTextView.text.count > 0 || (titleTextField?.text ?? "").count > 0 || gatheringLocation != nil {
            let cancelAlert = UIAlertController(
                title: nil,
                message: "작성중인 내용이 있습니다. 작성을 취소하시겠습니까?",
                preferredStyle: .alert
            )
            let cancel = UIAlertAction(title: "아니오", style: .cancel)
            let confirm = UIAlertAction(title: "예", style: .destructive, handler: {_ in
                self.dismiss(animated: true)
            })
            cancelAlert.addAction(cancel)
            cancelAlert.addAction(confirm)
            self.present(cancelAlert, animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        if let errorString = addGatheringInputErrorMessage() {
            let alert = UIAlertController(title: nil, message: errorString, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
        } else {
            let gatheringAddTestGathering = Gathering(
                title: titleTextField.text ?? "이름없음",
                host: MockData.bands[0], // 테스트용, 추후 변경
                status: .recruiting,
                date: dateTimePicker.date,
                location: gatheringLocation ?? Location(
                    name: "Default",
                    address: "defaultAddress",
                    additionalAddress: "defaultAdditionalAddress",
                    coordinate: Coordinate(latitude: 36.01900, longitude: 129.34370)
                ),
                introduction: introductionTextView.text,
                createdAt: Date()
            )
            MockData.gatherings.append(GatheringInfo(gatheringID: "testID", gathering: gatheringAddTestGathering)) // 추후 변경
            dismiss(animated: true)
        }
    }

    @IBAction func scrollViewTapRecognizer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    private func attribute() {
        setupNavigationBar()
        hostBandName = MockData.bands[0].band.name // 추후 변경: 유저디폴트 사용 예정
        hostBandNameLabel.text = hostBandName
        dateTimePicker.minimumDate = Date()
        titleTextField.becomeFirstResponder()
        getKeyboardNotification()
    }

    private func setDelegate() {
        introductionTextView.delegate = self
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupLayout() {
        view.addSubview(placeHolderLabel)
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: introductionTextView.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: introductionTextView.leadingAnchor, constant: 4)
        ])
    }
}

// MARK: - UITextViewDelegate

extension AddGatheringViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.textColor = introductionTextView.text.count == 0 ? .lightGray : .clear
    }
}

// MARK: - KeyboardControl

extension AddGatheringViewController {
    private func getKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo: NSDictionary = sender.userInfo as NSDictionary?,
              let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
                  return
              }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height

        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardHeight,
            right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        let contentInset = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: 0.0,
                right: 0.0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
    }
}

// MARK: - custom errors

extension AddGatheringViewController {
    enum AddGatheringInputError: Error {
        case noTitle
        case noLocation
        case noMultipleFields
    }

    private func validateInputs() throws {
        var errors: [AddGatheringInputError] = []
        if titleTextField.text == nil || (titleTextField.text ?? "").count <= 0 {
            errors.append(.noTitle)
        }
        if gatheringLocation == nil {
            errors.append(.noLocation)
        }
        
        if errors.count > 1 {
            throw AddGatheringInputError.noMultipleFields
        } else if errors.count == 1 {
            throw errors[0]
        }
    }

    private func addGatheringInputErrorMessage() -> String? {
        var errorString = ""
        do {
            try validateInputs()
        } catch AddGatheringInputError.noMultipleFields {
            errorString = "모여락의 이름, 장소를 입력해주세요"
        } catch AddGatheringInputError.noTitle {
            errorString = "모여락의 이름을 입력해주세요"
        } catch AddGatheringInputError.noLocation {
            errorString = "모여락의 장소를 입력해주세요"
        } catch {
            errorString = "입력을 확인하는 중 알 수 없는 문제가 발생했습니다"
        }
        if errorString.count <= 0 {
            return nil
        }
        return errorString
    }
}

// MARK: - Mock data set & test (위치 선택 구현 후 삭제 예정)

extension AddGatheringViewController {
    private func setAddGatheringTestData() {
        gatheringLocation = MockData.bands[1].band.location // 일부러 다른 밴드의 위치로 함
    }
}
