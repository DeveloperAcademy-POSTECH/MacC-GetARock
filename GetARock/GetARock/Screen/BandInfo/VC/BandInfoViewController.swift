//
//  BandInfoViewController.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/11/19.
//

import UIKit

// MARK: - 밴드 정보 영역 View Controller

class BandInfoViewController: UIViewController {
    
    @IBOutlet weak var bandMemberLabel: UILabel!
    @IBOutlet weak var bandMemberCollectionView: UICollectionView!
    @IBOutlet weak var bandIntroduceLabel: UILabel!
    @IBOutlet weak var bandIntroduceView: UIView!
    
    fileprivate let numberOfBandMember: Int = 7
    fileprivate let positionNameArray: [String] = ["보컬", "기타", "키보드", "드럼", "베이스", "그 외"]
    fileprivate let numberOfPostionArray: [Int] = [1, 2, 1, 1, 1, 0]
    fileprivate let bandIntroduceText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bandMemberLabel.text = "밴드 멤버 (\(numberOfBandMember)인)"
        
        bandMemberCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bandMemberCollectionView.dataSource = self
        
        self.bandMemberCollectionView.collectionViewLayout = createCompositionalLayout()
        
        bandIntroduceLabel.text = bandIntroduceText
        bandIntroduceView.backgroundColor = UIColor.backgroundBlue
        bandIntroduceView.layer.cornerRadius = 15
        bandIntroduceView.layer.borderWidth = 1
        bandIntroduceView.layer.borderColor = UIColor.dividerBlue.cgColor
    }
    
    override func viewWillLayoutSubviews() {
            bandIntroduceLabel.sizeToFit()
    }
}

// MARK: - 컬렉션뷰 compositonal layout 관련

extension BandInfoViewController {
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
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

// MARK: - 컬렉션뷰 데이터 삽입 관련

extension BandInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.positionNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: BandMemberCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as?
                BandMemberCollectionViewCell else { return UICollectionViewCell() }
        
        cell.positionNameLabel.text = self.positionNameArray[indexPath.item]
        cell.numberOfPositionLabel.text = "\(self.numberOfPostionArray[indexPath.item])명"
        
        return cell
    }
}
