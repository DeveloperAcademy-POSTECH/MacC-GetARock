//
//  AddGatheringLocationViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/12/02.
//

import UIKit

class AddGatheringLocationViewController: UIViewController {

    // MARK: - Property

    private var selectViewController: LocationSelectViewController?
    private var searchController: UISearchController?

    // MARK: - View

    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var addressDetailTextField: UITextField!
    
    @IBOutlet weak var guideLabel: UILabel!

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
        selectViewController = storyboard?.instantiateViewController(withIdentifier: "LocationSelectViewController") as? LocationSelectViewController
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
        // selectViewController?.tableView.delegate = self
    }
}

extension AddGatheringLocationViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // selectViewController?.tableView?.dataSource = selectViewController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
//        selectViewController?.tableView.dataSource = self
//        search(for: searchBar.text)
    }
}
