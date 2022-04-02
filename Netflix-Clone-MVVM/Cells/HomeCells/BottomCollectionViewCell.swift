//
//  BottomCollectionnViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 1.04.2022.
//

import UIKit
import Kingfisher

class BottomCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "BottomCollectionViewCell"
    
    private let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode  = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    override func layoutSubviews() {
        cellImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        cellImageView.kf.setImage(with: url)
    }
    
}
