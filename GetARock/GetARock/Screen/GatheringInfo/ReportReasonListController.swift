//
//  ReportReasonListController.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/22.
//

import UIKit

final class ReportReasonListController: UITableViewController, AlertSheet {
    
    // MARK: - Property
    
    private  let reportReason = ["폭력 또는 위험한 단체", "거짓 정보", "따돌림 또는 괴롭힘", "지적 재산권 침해", "불법 또는 규제 상품 판매", "기타 문제"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .modalBackgroundBlue
        tableView.tableHeaderView = makingHeader()
        
        let nib = UINib(nibName: ReportReasonListCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ReportReasonListCell.className)
    }
    
    // MARK: - Method
    
    func alertActionButtonPressed() {
        print("신고에 성공했습니다.")
    }
    
    func makingHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        header.backgroundColor = .modalBackgroundBlue
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "신고"
        headerLabel.textAlignment = .center
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        return header
    }

    // MARK: - TableView data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportReason.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportReasonListCell.className) as? ReportReasonListCell else { return UITableViewCell() }
        cell.reportReason.text = reportReason[indexPath.row]
        return cell
    }
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showAlertSheet(alertTitle: "신고하기", message: "\(reportReason[indexPath.row])을/(를) 사유로 신고하시겠습니까?")
    }

}
