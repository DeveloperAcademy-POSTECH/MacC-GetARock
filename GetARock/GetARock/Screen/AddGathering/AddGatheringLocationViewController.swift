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
    private var selectedCoordinate: Coordinate?

    // MARK: - View

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
        
    }
    
    private func attribute() {
        setupNavigationBarTitle()
        setupSearchController()
        setupSearchBar()
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
//        search(for: searchBar.text)
    }
}

// MARK: - Table View Delegate, Table View Datasource

extension AddGatheringLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        localSearch?.cancel()

        if places == nil {
            // searchFromSuggestion(for: selectViewController?.placeResults[(indexPath as NSIndexPath).row] as! MKLocalSearchCompletion)
        } else {
            setAddressInfos(indexPath: indexPath as NSIndexPath)
        }
        dismiss(animated: true)
    }

    func setAddressInfos (indexPath: NSIndexPath) { // MapItem
        selectedAddressLabel.text = CNPostalAddressFormatter.string(
            from: places?[(indexPath as NSIndexPath).row].placemark.postalAddress ?? CNPostalAddress(),
            style: .mailingAddress
        ).replacingOccurrences(of: "\n", with: " ")
        if let coordinate = places?[(indexPath as NSIndexPath).row].placemark.location?.coordinate {
            selectedCoordinate = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        print("\(String(describing: selectedCoordinate))")
    }
}

extension AddGatheringLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "LocationCandidateCell", for: indexPath) as? LocationCandidateCell
        else { return UITableViewCell() }

        cell.addressNameLabel?.text = places?[(indexPath as NSIndexPath).row].name ?? "이름없음"
        cell.addressLabel?.text = CNPostalAddressFormatter.string(
            from: places?[(indexPath as NSIndexPath).row].placemark.postalAddress ?? CNPostalAddress(),
            style: .mailingAddress
        ).replacingOccurrences(of: "\n", with: " ")

        return cell
    }
}
