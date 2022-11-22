//
//  ActionSheet.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/22.
//

import UIKit

protocol Reportable: UIViewController {
    var viewControllerToPresentWhenReported: UIViewController { get }

}

extension Reportable {
    func showActionSheet()  {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { action in
            print("삭제 로직을 구현해 주세요")
            
            print("delete")
        }
        let report = UIAlertAction(title: "신고하기", style: .default) { action in
            self.present(self.viewControllerToPresentWhenReported, animated: true)
        }
        
        actionSheet.addAction(report)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
       
        present(actionSheet, animated: true)
      
    }
}
