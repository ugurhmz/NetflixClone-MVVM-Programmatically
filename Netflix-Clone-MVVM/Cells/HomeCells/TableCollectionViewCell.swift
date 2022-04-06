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
    
    private func downloadMovieWithIndexPath(indexPath: IndexPath){
        
        print("downloading ->", movieDataList[indexPath.row])
    }
}



//MARK: -  Fill with Datas
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
    
  
    // cellForItemAt
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
    
    
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
       
        
       collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movieDataList[indexPath.row]
        print("HOOP",movie)
//        guard let titleName = movie.title else {
//            return
//        }
//

        var movieTitle =  (movie.title != nil) ? movie.title  : movie.original_name!
        
        DispatchQueue.main.async {
            MovieWebService.shared.getYoutubeMovies(with: movieTitle! + " trailer") { [weak self] result in
                

                    switch result {
                    case .success(let items):

                       // print("myitems ->",items[indexPath.row])

                        let movie = self?.movieDataList[indexPath.row]
                        guard let titleOverview = movie?.overview else {
                            return
                        }

                        guard let strongSelf = self else {
                            return
                        }

                        let youtubeViewModel = YoutubeVM(title: movieTitle!,
                                                         youtubeView: items,
                                                         titleOverview: titleOverview)
                        self?.youtubeDelegate?.tableCollectionViewCellDidTapCell(strongSelf,
                                                                                 youtubeVM: youtubeViewModel)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }

            }
        }
        
    }
   
    
    // hücreye basılı tutunca, download çıkması için
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil)  {  [weak self] _ in
            
            let homeDownloadBtnAction =  UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off ) { _ in
                print("download click")
                self?.downloadMovieWithIndexPath(indexPath: indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [homeDownloadBtnAction])
        }
        
        return config
    }
    
}
