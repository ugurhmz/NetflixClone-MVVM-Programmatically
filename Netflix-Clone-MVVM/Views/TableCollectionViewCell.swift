//
//  TableCollectionViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class TableCollectionViewCell: UITableViewCell {

    static var identifier =  "TableCollectionViewCell"
    
   
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // register
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cvCell")
        
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
  
    func setupViews(){
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


//MARK: - CollectionView Delegate, DataSource
extension TableCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath)
        cell.backgroundColor = .green
        
        return cell
    }
    
    
}
