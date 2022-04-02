//
//  SearchResultsController.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 2.04.2022.
//

import UIKit

class SearchResultsController: UIViewController {

    private var searchList: [MovieData] = []
    
    
    private let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15,
                                 height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BottomCollectionViewCell.self,
                                forCellWithReuseIdentifier: BottomCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .orange
        [searchResultCollectionView].forEach { view.addSubview($0)}
        
        searchResultCollectionView.frame = view.bounds
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }

}


//MARK: - Delegate, DataSource
extension SearchResultsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.identifier, for: indexPath)  as! BottomCollectionViewCell
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
    
}
