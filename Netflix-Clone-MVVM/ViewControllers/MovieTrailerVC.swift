//
//  MovieTrailerVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 3.04.2022.
//

import UIKit
import WebKit

class MovieTrailerVC: UIViewController {

    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
  
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fight Club"
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "lorem ipsum dolar sit amet lorem ipsum dolar sit amet"
        return label
    }()
    
    
    private let downloadBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red.withAlphaComponent(0.7)
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    private func setupViews() {
        [webView,titleLabel, overview, downloadBtn].forEach {  view.addSubview($0)}
        view.backgroundColor = .systemBackground
        setConstraints()
        webView.backgroundColor = .blue
    }
    
}

extension MovieTrailerVC {
    
    public func configure(with model: YoutubeVM) {
        titleLabel.text = model.title
        overview.text  = model.titleOverview

        print("mymodel", model.youtubeView.id!.videoID!)
       
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(model.youtubeView.id!.videoID!)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}




//MARK: - Constraints
extension MovieTrailerVC {
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 450),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            overview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            downloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBtn.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 25),
            downloadBtn.widthAnchor.constraint(equalToConstant: 140),
            downloadBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
