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
    var placeResults: [MKLocalSearchCompletion] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - View

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "LocationCandidateCell", bundle: nil) //.className이 잘 작동 안해서 일단 이렇게 쓰는 중
        tableView.register(nibName, forCellReuseIdentifier: "LocationCandidateCell")
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startProvidingCompletions()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopProvidingCompletions()
    }

    // MARK: - Method

    private func startProvidingCompletions() {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        // MKCoordinateRegion 필요시 설정. 한국 등은 여기 말고 placemark의 countryCode에서 처리
        // searchCompleter?.region = searchRegion
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
    }
}

// MARK: - MK Local Search Completer Delegate (지역검색 결과 업데이트)

extension LocationSelectViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        placeResults = completer.results
    }
}

// MARK: - Search Results Updating (search controller 관련)

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCandidateCell", for: indexPath) as?
                LocationCandidateCell else {
            return UITableViewCell()
        }
        cell.addressNameLabel?.text = placeResults[(indexPath as NSIndexPath).row].title
        cell.addressLabel?.text = placeResults[(indexPath as NSIndexPath).row].subtitle

        return cell
    }
}
