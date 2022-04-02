//
//  SearchResultsController.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 2.04.2022.
//

import UIKit

class SearchResultsController: UIViewController {

    public var resultList: [MovieData] = []
    
    public var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15,
                                 height: 200)
        layout.minimumInteritemSpacing = 0
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // register
        collectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCollectionViewCell.identifier)
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
        return resultList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.identifier, for: indexPath) as? BottomCollectionViewCell else {
                    return UICollectionViewCell()
                }
        
        let mymodel = resultList[indexPath.row]
        
        cell.configure(with: mymodel.poster_path ?? "")
      
        
        return cell
    }
    
    
}
