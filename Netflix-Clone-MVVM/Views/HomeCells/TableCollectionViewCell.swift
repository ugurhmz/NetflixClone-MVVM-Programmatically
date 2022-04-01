//
//  TableCollectionViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class TableCollectionViewCell: UITableViewCell {

    static  var identifier =  "TableCollectionViewCell"
    private var movieDataList: [MovieData] = [MovieData]()
    
    
    
    
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // register
        cv.register(BottomCollectionViewCell.self,
                    forCellWithReuseIdentifier: BottomCollectionViewCell.identifier)
        
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews(){
        contentView.backgroundColor = .systemPink
        contentView.addSubview(generalCollectionView)
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        generalCollectionView.frame = contentView.bounds
    }
}


extension TableCollectionViewCell {
    
    public func configure(with mvList: [MovieData]) {
        self.movieDataList = mvList
        
        DispatchQueue.main.async { [weak self] in
            self?.generalCollectionView.reloadData()
        }
    }
    
}




//MARK: - CollectionView Delegate, DataSource
extension TableCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.movieDataList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        guard let bottomCells = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.identifier, for: indexPath)
                as? BottomCollectionViewCell else { return UICollectionViewCell() }
        
        
        guard let model = movieDataList[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        
        bottomCells.configure(with: model)
        
        return bottomCells
    }
    
    
}
