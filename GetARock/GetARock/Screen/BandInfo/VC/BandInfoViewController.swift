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
    
    var bandInfo: BandInfo? {
        didSet {
            reflectBandInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .modalBackgroundBlue
        setUI()
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
    private func setUI() {
        setBandMemberAreaUI()
        setRepertoireAreaUI()
        setBandIntroduceAreaUI()
        reflectBandInfo()
    }
    
    private func setBandMemberAreaUI() {
        bandMemberCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bandMemberCollectionView.dataSource = self
        bandMemberCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func setRepertoireAreaUI() {
        let repertoireTableViewCellNib = UINib(nibName: RepertoireTableViewCell.className, bundle: nil)
        
        repertoireTableView.register(repertoireTableViewCellNib, forCellReuseIdentifier: RepertoireTableViewCell.className)
        repertoireTableView.rowHeight = UITableView.automaticDimension
        repertoireTableView.estimatedRowHeight = 60
        repertoireTableView.dataSource = self
    }
    
    private func setBandIntroduceAreaUI() {
        bandIntroduceView.backgroundColor = UIColor.backgroundBlue
        bandIntroduceView.layer.cornerRadius = 15
        bandIntroduceView.layer.borderWidth = 1
        bandIntroduceView.layer.borderColor = UIColor.dividerBlue.cgColor
    }
    
    private func reflectBandInfo() {
        bandIntroduceLabel.text = bandInfo?.band.introduction
        bandMemberLabel.text = "밴드 멤버 (\(bandInfo?.band.getNumberOfMembers() ?? 0)인)"
        bandAgeLabel.text = generateBandAgeLabelText()
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
        return self.bandInfo?.band.filledPosition.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BandMemberCollectionViewCell.className,
            for: indexPath
        ) as? BandMemberCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.positionNameLabel.text = self.bandInfo?.band.filledPosition[indexPath.item].position.toKorean()
        cell.numberOfPositionLabel.text = "\(self.bandInfo?.band.filledPosition[indexPath.item].numberOfPerson ?? 0)명"
        
        return cell
    }
}

// MARK: - Label 텍스트에 연결하는 변수 관련

extension BandInfoViewController {
    private func generateBandAgeLabelText() -> String {
        guard let bandInfo = bandInfo else { return "" }
        for num in 0...bandInfo.band.ageGroups.count - 1 {
            bandAgeLabel.text?.append(bandInfo.band.ageGroups[num].toKorean())
            if num != bandInfo.band.ageGroups.count - 1 {
                bandAgeLabel.text?.append(", ")
            }
        }
        return bandAgeLabel.text ?? ""
    }
    
    private func calculateNumberOfBandMemberText() -> Int {
        guard let bandInfo = bandInfo else { return 0 }
        var sum = 0
        for num in 0...bandInfo.band.filledPosition.count - 1 {
            sum += bandInfo.band.filledPosition[num].numberOfPerson
        }
        return sum
    }
    
    private func appendPositionNameArray() -> [String] {
        guard let bandInfo = bandInfo else { return [] }
        var positionNameArray: [String] = []
        for num in 0...bandInfo.band.filledPosition.count - 1 {
            positionNameArray.append(bandInfo.band.filledPosition[num].position.toKorean())
        }
        return positionNameArray
    }
    
    private func appendNumberOfPostionArray() -> [Int] {
        guard let bandInfo = bandInfo else { return [] }
        var numberOfPositionArray: [Int] = []
        for num in 0...bandInfo.band.filledPosition.count - 1 {
            numberOfPositionArray.append(bandInfo.band.filledPosition[num].numberOfPerson)
        }
        return numberOfPositionArray
    }
    
    private func appendBandAgeArray() -> [String] {
        guard let bandInfo = bandInfo else { return [] }
        var bandAgeArray: [String] = []
        for num in 0...bandInfo.band.ageGroups.count - 1 {
            bandAgeArray.append(bandInfo.band.ageGroups[num].toKorean())
        }
        return bandAgeArray
    }
}

// MARK: - 테이블뷰 데이터 삽입 관련

extension BandInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bandInfo?.band.repertoire.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repertoireTableView.dequeueReusableCell(
            withIdentifier: RepertoireTableViewCell.className,
            for: indexPath
        ) as? RepertoireTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.repertoireLabel.text = bandInfo?.band.repertoire[indexPath.row] ?? ""
        
        return cell
    }
}
