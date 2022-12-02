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
    
    func attribute() {
        setupSearchController()
        setupSearchBar()
    }

    func setupSearchController() {
        selectViewController = storyboard?.instantiateViewController(withIdentifier: "LocationSelectViewController") as? LocationSelectViewController
        searchController = UISearchController(searchResultsController: selectViewController)
    }

    func setupSearchBar() {
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
