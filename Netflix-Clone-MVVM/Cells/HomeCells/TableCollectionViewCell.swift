//
//  TableCollectionViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

protocol TableCollectionViewCellProtocol: AnyObject {
    func tableCollectionViewCellDidTapCell(_ cell: TableCollectionViewCell, youtubeVM: YoutubeVM )
}


class TableCollectionViewCell: UITableViewCell {

    static  var identifier =  "TableCollectionViewCell"
    private var movieDataList: [MovieData] = [MovieData]()
    
    weak var youtubeDelegate: TableCollectionViewCellProtocol?
    
    
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
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movieDataList[indexPath.row]
        
        guard let titleName = movie.title else {
            return
        }
       
         
        
        MovieWebService.shared.getYoutubeMovies(with: titleName + " trailer") { [weak self] result in
           
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                  
                    print("myitems ->",items)
                    
                    let movie = self?.movieDataList[indexPath.row]
                    guard let titleOverview = movie?.overview else {
                        return
                    }
    
                    let youtubeViewModel = YoutubeVM(title: titleName,
                                                     youtubeView: items[indexPath.row],
                                                     titleOverview: titleOverview)
    
                    guard let strongSelf = self else {
                        return
                    }
    
                    self?.youtubeDelegate?.tableCollectionViewCellDidTapCell(strongSelf,
                                                                       youtubeVM: youtubeViewModel)
                    self?.generalCollectionView.reloadData()

                case .failure(let error):
                    print(error.localizedDescription)
                }
               
            }
        }
        
    }
    
    
}
