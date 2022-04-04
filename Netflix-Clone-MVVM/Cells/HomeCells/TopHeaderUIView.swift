//
//  TopHeaderUIView.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit
import Kingfisher

class TopHeaderUIView: UIView {

    
    // topImageView
    private let topImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a3")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    // black Gradient
    private func blackGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
              
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    // play btn
    private let playBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderWidth = 1.2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.zPosition = 1
        
        return button
    }()
    
    // download btn
    private let downloadBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        [topImageView, playBtn, downloadBtn].forEach { addSubview($0) }
        
        
        topImageView.frame = bounds
        blackGradient()
        setAllConstraints()
    }
  
    
    // home'dan gelen
    func configure(with myMoviemodel: [MovieData]) {
        print("gelenmodel",myMoviemodel.count)
        
        let randomMovieElement = myMoviemodel.randomElement()
        
        guard let imgUrl = randomMovieElement?.poster_path else {
            return
        }
        
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imgUrl)") else { return }
        
        print(randomMovieElement!.poster_path!)
        topImageView.kf.setImage(with: url)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}


//MARK: -
extension TopHeaderUIView {
    private func  setAllConstraints(){
        NSLayoutConstraint.activate([
            
            
            // playBtn
            playBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            playBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            playBtn.widthAnchor.constraint(equalToConstant: 125),
        
        
            // downloadBtn
            downloadBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            downloadBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            downloadBtn.widthAnchor.constraint(equalToConstant: 125)
        
        ])
    }
    
}
