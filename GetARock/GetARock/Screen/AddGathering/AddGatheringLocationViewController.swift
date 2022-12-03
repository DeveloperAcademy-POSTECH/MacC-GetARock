//
//  AddGatheringLocationViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/12/02.
//

import Contacts
import MapKit
import UIKit

class AddGatheringLocationViewController: UIViewController {

    // MARK: - Property

    private var places: [MKMapItem]? {
        didSet {
            if places != nil {
                selectViewController?.tableView.reloadData()
            }
        }
    }

    private var localSearch: MKLocalSearch?
    private var selectedLocationName: String?
    private var selectedCoordinate: Coordinate?

    weak var delegate: AddGatheringLocationViewControllerDelegate?

    // MARK: - View

    @IBOutlet weak var addressStackView: UIStackView!
    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var addressDetailTextField: UITextField!
    
    @IBOutlet weak var guideLabel: UILabel!

    private var searchController: UISearchController?
    private var selectViewController: LocationSelectViewController?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

    // MARK: - Method

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        if delegate != nil {
            if let coordinate = selectedCoordinate {
                delegate?.setLocation(
                    name: selectedLocationName,
                    address: selectedAddressLabel.text,
                    additionalAddress: addressDetailTextField.text,
                    coordinate: coordinate
                )
                navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(
                    title: nil,
                    message: "주소가 올바르지 않습니다",
                    preferredStyle: .alert
                )
                let confirm = UIAlertAction(title: "예", style: .default, handler: {_ in
                    print("입력 주소(비어있을 수 있음)에 해당하는 좌표를 찾지 못함")
                    self.dismiss(animated: true)
                })
                alertController.addAction(confirm)
                self.present(alertController, animated: true)
            }
        } else {
            print("AddgatheringLocationViewController에서 delgate가 nil이라 저장할 수 없음")
        }
    }
    
    private func attribute() {
        setupNavigationBarTitle()
        setupSearchController()
        setupSearchBar()
        addressStackView.isHidden = true
    }
    
    private func setupNavigationBarTitle() {
        let titleLabel: UILabel = {
            $0.text = "장소 선택"
            $0.font = .preferredFont(forTextStyle: .headline)
            return $0
        }(UILabel())
        self.navigationItem.titleView = titleLabel
    }

    private func setupSearchController() {
        selectViewController = storyboard?
            .instantiateViewController(withIdentifier: "LocationSelectViewController") as? LocationSelectViewController
        searchController = UISearchController(searchResultsController: selectViewController)
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.searchResultsUpdater = selectViewController
    }

    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.automaticallyShowsCancelButton = false
        searchController?.searchBar.placeholder = "어디에서 만나나요?"
        searchController?.searchBar.tintColor = .white
        searchController?.searchBar.setImage(
            UIImage(systemName: "magnifyingglass"),
            for: UISearchBar.Icon.search,
            state: .normal
        )
        searchController?.searchBar.searchTextField.font = .preferredFont(forTextStyle: .subheadline)
        searchController?.searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.1)
        searchController?.searchBar.searchTextField.layer.cornerRadius = 12
        searchController?.searchBar.searchTextField.layer.borderWidth = 1
        searchController?.searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
        searchController?.searchBar.searchTextField.clipsToBounds = true
    }
}

// MARK: - Search Controller Delegate, Search Bar Delegate

extension AddGatheringLocationViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        selectViewController?.tableView.delegate = self
    }
}

extension AddGatheringLocationViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        selectViewController?.tableView?.dataSource = selectViewController
        places = nil
        localSearch?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        selectViewController?.tableView.dataSource = self
        searchFromString(for: searchBar.text)
    }
}

// MARK: - MK Local Search (맵킷 사용 주소 검색)

extension AddGatheringLocationViewController {
    private func searchFromSuggestion(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest, isTapped: true)
    }

    private func searchFromString(for queryString: String?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
        search(using: searchRequest, isTapped: false)
    }

    private func search(using searchRequest: MKLocalSearch.Request, isTapped: Bool) {
        self.localSearch = MKLocalSearch(request: searchRequest)
        self.localSearch?.start { [unowned self] (response, error) in
            guard error == nil else {
                self.displaySearchError(error)
                return
            }

            self.places = response?.mapItems
            if isTapped {
                if self.places?.count ?? 0 > 0 {
                    localSearch?.cancel()
                    setAddressInfos(indexPath: NSIndexPath(row: 0, section: 0))
                }
            }
        }
    }

    func displaySearchError(_ error: Error?) {
        guard let error = error as NSError? else { return }
        
        let alertController = UIAlertController(
            title: nil,
            message: "검색결과가 없습니다. 검색어를 확인해주세요.",
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(title: "예", style: .default, handler: {_ in
            print("장소 검색 에러: \(error.description)")
            self.dismiss(animated: true)
        })
        alertController.addAction(confirm)
        self.present(alertController, animated: true)
    }
}

// MARK: - Table View Delegate, Table View Datasource

extension AddGatheringLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        localSearch?.cancel()

        if places == nil {
            if let selectedSearchCompletion = selectViewController?
                    .placeResults[(indexPath as NSIndexPath).row] as? MKLocalSearchCompletion {
                searchFromSuggestion(for: selectedSearchCompletion)
            }
        } else {
            setAddressInfos(indexPath: indexPath as NSIndexPath)
        }
        dismiss(animated: true)
    }

    func setAddressInfos (indexPath: NSIndexPath) { // MapItem
        selectedLocationName = places?[(indexPath as NSIndexPath).row].name
        selectedAddressLabel.text = CNPostalAddressFormatter.string(
            from: places?[(indexPath as NSIndexPath).row].placemark.postalAddress ?? CNPostalAddress(),
            style: .mailingAddress
        ).replacingOccurrences(of: "\n", with: " ")
        if let coordinate = places?[(indexPath as NSIndexPath).row].placemark.location?.coordinate {
            selectedCoordinate = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        addressStackView.isHidden = false
        guideLabel.isHidden = true
    }
}

extension AddGatheringLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: LocationCandidateCell.className, for: indexPath) as? LocationCandidateCell
        else { return UITableViewCell() }

        cell.addressNameLabel?.text = places?[(indexPath as NSIndexPath).row].name ?? "이름없음"
        cell.addressLabel?.text = CNPostalAddressFormatter.string(
            from: places?[(indexPath as NSIndexPath).row].placemark.postalAddress ?? CNPostalAddress(),
            style: .mailingAddress
        ).replacingOccurrences(of: "\n", with: " ")

        return cell
    }
}

// MARK: - Delegate Protocol to set location in parent view

protocol AddGatheringLocationViewControllerDelegate: AnyObject {
    func setLocation(name: String?, address: String?, additionalAddress: String?, coordinate: Coordinate)
}
