//
//  ActionSheet.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/22.
//

import UIKit

protocol Reportable: UIViewController, AlertSheet {

}
extension Reportable {
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
            self.showAlertSheet(alertTitle: "삭제하기", message: "삭제하시겠습니까?")
        }
        let report = UIAlertAction(title: "신고하기", style: .default) { _ in
            self.present(ReportReasonListController(), animated: true)
            
        }
    
        actionSheet.addAction(report)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
       
        present(actionSheet, animated: true)
      
    }
}

protocol AlertSheet: UIViewController {
    func alertActionButtonPressed()
}

extension AlertSheet {
    func showAlertSheet(alertTitle: String, message: String) {
        let alertSheet = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        let action = UIAlertAction(title: alertTitle, style: .destructive) { _ in
            self.alertActionButtonPressed()
        }
        
        alertSheet.addAction(action)
        alertSheet.addAction(cancel)
        
        present(alertSheet, animated: true)
        
    }
}
