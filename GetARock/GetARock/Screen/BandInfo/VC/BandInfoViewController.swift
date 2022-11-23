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
    @IBOutlet weak var bandAgeLabel: UILabel!
    @IBOutlet weak var repertoireTableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    private let numberOfBandMember: Int = 7
    private let positionNameArray: [String] = ["보컬", "기타", "키보드", "드럼", "베이스", "그 외"]
    private let numberOfPostionArray: [Int] = [1, 2, 1, 1, 1, 0]
    private let bandIntroduceText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    private let bandAgeArray: [String] = ["20대", "30대", "40대"]
    private let repertoireArray: [String] = ["Bigbang - Haruharu", "빅뱅 - 붉은노을", "이브 - 제목이 짤릴 정도로 긴 노래를 만들어 보았다람쥐"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBandMemberAreaUI()
        setBandAgeAreaUI()
        setRepertoireAreaUI()
        setBandIntroduceAreaUI()
    }
    
    override func updateViewConstraints() {
        tableHeightConstraint.constant = repertoireTableView.contentSize.height
        super.updateViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        bandIntroduceLabel.sizeToFit()
    }
}

// MARK: - UI 설정 관련

extension BandInfoViewController {
    func setBandMemberAreaUI() {
        bandMemberLabel.text = "밴드 멤버 (\(numberOfBandMember)인)"
        
        bandMemberCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bandMemberCollectionView.dataSource = self
        bandMemberCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func setBandAgeAreaUI() {
        bandAgeLabel.text = generateBandAgeLabelText()
    }
    
    func setRepertoireAreaUI() {
        let repertoireTableViewCellNib = UINib(nibName: RepertoireTableViewCell.className, bundle: nil)
        
        repertoireTableView.register(repertoireTableViewCellNib, forCellReuseIdentifier: RepertoireTableViewCell.className)
        repertoireTableView.rowHeight = UITableView.automaticDimension
        repertoireTableView.estimatedRowHeight = 60
        repertoireTableView.dataSource = self
    }
    
    func setBandIntroduceAreaUI() {
        bandIntroduceLabel.text = bandIntroduceText
        
        bandIntroduceView.backgroundColor = UIColor.backgroundBlue
        bandIntroduceView.layer.cornerRadius = 15
        bandIntroduceView.layer.borderWidth = 1
        bandIntroduceView.layer.borderColor = UIColor.dividerBlue.cgColor
    }
}

// MARK: - 컬렉션뷰 compositonal layout 관련

extension BandInfoViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BandMemberCollectionViewCell else { return UICollectionViewCell() }
        
        cell.positionNameLabel.text = self.positionNameArray[indexPath.item]
        cell.numberOfPositionLabel.text = "\(self.numberOfPostionArray[indexPath.item])명"
        
        return cell
    }
}

// MARK: - 밴드 연령대 Label 관련

extension BandInfoViewController {
    private func generateBandAgeLabelText() -> String {
        for num in 0...bandAgeArray.count - 1 {
            bandAgeLabel.text?.append(bandAgeArray[num])
            if num != bandAgeArray.count - 1 {
                bandAgeLabel.text?.append(", ")
            }
        }
        return bandAgeLabel.text ?? ""
    }
}

extension BandInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repertoireArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repertoireTableView.dequeueReusableCell(withIdentifier: RepertoireTableViewCell.className, for: indexPath) as? RepertoireTableViewCell else { return UITableViewCell() }
        
        cell.repertoireLabel.text = repertoireArray[indexPath.row]
        
        return cell
    }
}
