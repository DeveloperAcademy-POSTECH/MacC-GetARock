//
//  LocationSelectViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/12/02.
//

import MapKit
import UIKit

class LocationSelectViewController: UIViewController {

    // MARK: - Property

    var searchCompleter: MKLocalSearchCompleter?

    // MARK: - View

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension LocationSelectViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter?.queryFragment = searchController.searchBar.text ?? ""
    }
}
