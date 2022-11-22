//
//  ActionSheet.swift
//  GetARock
//
//  Created by 진영재 on 2022/11/22.
//

import UIKit

protocol Reportable { }

extension Reportable {
    func showActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { action in
            
            print("delete")
        }
        let report = UIAlertAction(title: "신고하기", style: .default) { action in
            print("report")
        }
        
        actionSheet.addAction(report)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        
        return actionSheet
    }
}
