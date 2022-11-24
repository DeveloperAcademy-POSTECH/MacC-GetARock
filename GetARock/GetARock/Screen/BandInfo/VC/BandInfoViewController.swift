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
    
    private lazy var numberOfBandMember: Int = calculateNumberOfBandMemberText()
    private lazy var positionNameArray: [String] = appendPositionNameArray()
    private lazy var numberOfPostionArray: [Int] = appendNumberOfPostionArray()
    private lazy var bandAgeArray: [String] = appendBandAgeArray()
    private lazy var repertoireArray: [String] = selectedBand.repertoire
    private lazy var bandIntroduceText = selectedBand.introduction
    
    private let selectedBand: Band = MockData.bands[0].band
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .modalBackgroundBlue
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
    private func setBandMemberAreaUI() {
        bandMemberLabel.text = "밴드 멤버 (\(numberOfBandMember)인)"
        
        bandMemberCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bandMemberCollectionView.dataSource = self
        bandMemberCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func setBandAgeAreaUI() {
        bandAgeLabel.text = generateBandAgeLabelText()
    }
    
    private func setRepertoireAreaUI() {
        let repertoireTableViewCellNib = UINib(nibName: RepertoireTableViewCell.className, bundle: nil)
        
        repertoireTableView.register(repertoireTableViewCellNib, forCellReuseIdentifier: RepertoireTableViewCell.className)
        repertoireTableView.rowHeight = UITableView.automaticDimension
        repertoireTableView.estimatedRowHeight = 60
        repertoireTableView.dataSource = self
    }
    
    private func setBandIntroduceAreaUI() {
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

// MARK: - Label 텍스트에 연결하는 변수 관련

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
    
    private func calculateNumberOfBandMemberText() -> Int {
        var sum = 0
        for num in 0...selectedBand.filledPosition.count - 1 {
            sum += selectedBand.filledPosition[num].numberOfPerson
        }
        return sum
    }
    
    private func appendPositionNameArray() -> [String] {
        var positionNameArray: [String] = []
        for num in 0...selectedBand.filledPosition.count - 1 {
            positionNameArray.append(selectedBand.filledPosition[num].position.toKorean())
        }
        return positionNameArray
    }
    
    private func appendNumberOfPostionArray() -> [Int] {
        var numberOfPositionArray: [Int] = []
        for num in 0...selectedBand.filledPosition.count - 1 {
            numberOfPositionArray.append(selectedBand.filledPosition[num].numberOfPerson)
        }
        return numberOfPositionArray
    }
    
    private func appendBandAgeArray() -> [String] {
        var bandAgeArray: [String] = []
        for num in 0...selectedBand.ageGroups.count - 1 {
            bandAgeArray.append(selectedBand.ageGroups[num].toKorean())
        }
        return bandAgeArray
    }
}

// MARK: - 테이블뷰 데이터 삽입 관련

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
