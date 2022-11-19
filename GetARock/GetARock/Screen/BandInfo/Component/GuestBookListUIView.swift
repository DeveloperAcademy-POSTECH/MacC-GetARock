//
//  GuestBookUIView.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/19.
//

import UIKit

class GuestBookListUIView: UIView {
    
    private let reuseIdentifier = "GusetBookTableCell"
    
    private let tableView = UITableView()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setGuestBookList() {
        self.addSubview(tableView)
    }
    
}

// MARK: - UITableViewDelegate
extension GuestBookListUIView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension GuestBookListUIView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
    

}
