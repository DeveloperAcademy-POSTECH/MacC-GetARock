//
//  BandInfoViewController.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/19.
//

import UIKit

class BandInfoViewController: UIViewController {
    
    @IBOutlet weak var bandMemberLabel: UILabel!
    @IBOutlet var bandMemberCollectionView: UICollectionView!
    
    private var bandMemberNumber: Int = 7
    fileprivate let instrumentNameArray: [String] = ["보컬", "기타", "키보드", "드럼", "베이스", "그 외"]
    fileprivate let instrumentNumberArray: [Int] = [1, 2, 1, 1, 1, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bandMemberLabel.text = "밴드 멤버 (\(bandMemberNumber)명)"
        
        bandMemberCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bandMemberCollectionView.dataSource = self
        
        self.bandMemberCollectionView.collectionViewLayout = createCompositionalLayout()
    }
}

// MARK: - 콜렉션뷰 compositonal layout 관련
extension BandInfoViewController {
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
        
        return layout
    }
}

extension BandInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.instrumentNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: BandMemberCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BandMemberCollectionViewCell
        
        cell.contentView.backgroundColor = UIColor.appColor(.backgroundBlue)
        cell.contentView.layer.cornerRadius = 14
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.appColor(.dividerBlue).cgColor
        
        cell.instrumentName.text = self.instrumentNameArray[indexPath.item]
        cell.instrumentNumber.text = "\(self.instrumentNumberArray[indexPath.item])명"
        
        return cell
    }
}
