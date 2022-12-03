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

    var placeResults: [MKLocalSearchCompletion] = []
//    {
//        didSet {
//            print("didSet placeResults count: \(placeResults.count)")
//            tableView.reloadData()
//        }
//    }

    var searchCompleter: MKLocalSearchCompleter?

    // MARK: - View

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "LocationCandidateCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "LocationCandidateCell")
        tableView.dataSource = self
    }

}

// MARK: - Search Results Updating

extension LocationSelectViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter?.queryFragment = searchController.searchBar.text ?? ""
    }
}

// MARK: - Table View Data Source

extension LocationSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCandidateCell", for: indexPath) as? LocationCandidateCell else { return UITableViewCell() }
//        cell.titleLabel?.text = placeResults[(indexPath as NSIndexPath).row].title
//        cell.addressLabel?.text = placeResults[(indexPath as NSIndexPath).row].subtitle

        return cell
    }
}
