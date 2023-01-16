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
    @IBOutlet weak var locationLabel: UILabel!
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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let locationSearchViewController = segue.destination as? LocationSearchViewController {
            locationSearchViewController.delegate = self
        }
    }

    deinit {
        removeObserversForKeyboardShow()
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
            guard let gatheringLocation = gatheringLocation else {
                return // 위의 errorString에서 체크 완료한 부분입니다.
            }
            let gathering = Gathering(
                title: titleTextField.text ?? "이름없음",
                host: MockData.bands[0], // 테스트용 - 추후 변경
                status: .recruiting,
                date: dateTimePicker.date,
                location: gatheringLocation,
                introduction: introductionTextView.text,
                createdAt: Date()
            )
            MockData.gatherings.append(GatheringInfo(gatheringID: "testID", gathering: gathering)) // 테스트용 - ID 추후 변경
            dismiss(animated: true)
        }
    }

    @IBAction func scrollViewTapRecognizer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    private func attribute() {
        setupNavigationBar()
        hostBandName = MockData.bands[0].band.name // 테스트용 - 추후 변경: 유저디폴트 사용 예정
        hostBandNameLabel.text = hostBandName
        dateTimePicker.minimumDate = Date()
        titleTextField.becomeFirstResponder()
        addObeserversForKeyboardShow()
    }

    private func setDelegate() {
        introductionTextView.delegate = self
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        title = ""
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
        self.placeHolderLabel.textColor = introductionTextView.text.isEmpty ? .lightGray : .clear
    }
}

// MARK: - Location Delegate

extension AddGatheringViewController: LocationSearchViewControllerDelegate {
    func setLocation(name: String?, address: String?, additionalAddress: String?, coordinate: Coordinate) {
        gatheringLocation = Location(name: name, address: address, additionalAddress: additionalAddress, coordinate: coordinate)
        var gatheringAddress = address ?? ""
        if let detailAddress = additionalAddress {
            gatheringAddress += " " + detailAddress
        }
        if !gatheringAddress.isEmpty {
            locationLabel.text = gatheringAddress
            locationLabel.textColor = .white
        }
    }
}

// MARK: - custom errors

extension AddGatheringViewController {
    enum AddGatheringInputError: Error {
        case noTitle
        case noLocation
        case noMultipleFields
        
        var errorMessage: String {
            switch self {
            case .noTitle:
                return "모여락의 이름을 입력해주세요"
            case .noLocation:
                return "모여락의 장소를 입력해주세요"
            case .noMultipleFields:
                return "모여락의 이름, 장소를 입력해주세요"
            }
        }
    }

    private func validateInputs() throws {
        var errors: [AddGatheringInputError] = []
        if titleTextField.text == nil || (titleTextField.text ?? "").filter({$0 != " "}).isEmpty {
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
        do {
            try validateInputs()
        } catch {
            if let error = error as? AddGatheringInputError {
                return error.errorMessage
            }
            return "입력을 확인하는 중 알 수 없는 문제가 발생했습니다"
        }
        return nil
    }
}
