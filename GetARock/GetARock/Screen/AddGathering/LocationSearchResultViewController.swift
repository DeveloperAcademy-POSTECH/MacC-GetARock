//
//  LocationSearchResultViewController.swift
//  GetARock
//
//  Created by Hyorim Nam on 2022/12/02.
//

import MapKit
import UIKit

class LocationSearchResultViewController: UIViewController {

    // MARK: - Property

    var searchCompleter: MKLocalSearchCompleter?
    var suggestedPlaces: [MKLocalSearchCompletion] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - View

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startProvidingCompletions()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopProvidingCompletions()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Method

    private func attribute() {
        setupTableView()
        getKeyboardNotification()
    }

    private func setupTableView() {
        let nibName = UINib(nibName: LocationCandidateCell.className, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: LocationCandidateCell.className)
        tableView.dataSource = self
    }

    private func startProvidingCompletions() {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
    }
}

// MARK: - MK Local Search Completer Delegate (지역검색 결과 업데이트)

extension LocationSearchResultViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestedPlaces = completer.results.filter { $0.subtitle.contains("대한민국") }
    }
}

// MARK: - Search Results Updating (search controller 관련)

extension LocationSearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter?.queryFragment = searchController.searchBar.text ?? ""
    }
}

// MARK: - Table View Data Source

extension LocationSearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCandidateCell.className, for: indexPath) as?
                LocationCandidateCell else {
            return UITableViewCell()
        }
        cell.locationNameLabel?.text = suggestedPlaces[(indexPath as NSIndexPath).row].title
        cell.addressLabel?.text = suggestedPlaces[(indexPath as NSIndexPath).row].subtitle

        return cell
    }
}

// MARK: - KeyboardControl

extension LocationSearchResultViewController {
    private func getKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
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
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        let contentInset = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: 0.0,
                right: 0.0)
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset
    }
}
