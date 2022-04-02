//
//  UpComingTableViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 1.04.2022.
//

import UIKit
import Kingfisher

class UpComingTableViewCell: UITableViewCell {

    static var identifier = "UpComingTableViewCell"
    private let randomImage: String = "https://picsum.photos/200/300"
    
    private let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let playBtn: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        [cellImageView, titleLabel, playBtn].forEach { contentView.addSubview($0) }
        setContraints()
    }
  
    
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }

}


//MARK: -
extension UpComingTableViewCell {
  
        
    public func configure(movie: MovieData) {
        
        
        guard let movieImage = movie.poster_path else { return }
        
     
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieImage)") else { return}
       
        cellImageView.kf.setImage(with:  url)
        
        titleLabel.text = movie.title
        
    }
        
}




//MARK: - Constraints
extension UpComingTableViewCell {
    
    private func setContraints(){
        NSLayoutConstraint.activate([
            
            //cellImageViewConstraints
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellImageView.widthAnchor.constraint(equalToConstant: 120),
            
            
            // titleLabelConstraints
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            // playBtnConstraints
            playBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                              constant: -20),
            playBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
            
        ])
    }
}
