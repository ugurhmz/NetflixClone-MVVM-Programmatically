//
//  MovieTrailerVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 3.04.2022.
//

import UIKit
import WebKit

class MovieTrailerVC: UIViewController, UIScrollViewDelegate {
    
    static var myArr: MovieData?
    var viewModel = DownloadViewModel()
    var scroll = UIScrollView()
    
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
    
    
    private var downloadBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red.withAlphaComponent(0.7)
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        return button
    }()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        scroll.delegate = self
        
        print("datam", MovieTrailerVC.myArr)
    }
    
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX:  0,
                                                              y: min(0, offset))
    }

    
    
    private func setupViews() {
        [scroll,webView,titleLabel, overview, downloadBtn].forEach {  view.addSubview($0)}
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    
    @objc func buttonAction(){
            
        viewModel.downloadMovieWithIndexPath(sendHomeMovie: MovieTrailerVC.myArr ?? MovieData(id: 0, media_type: nil, original_name: nil, poster_path: nil, title: nil, overview: nil, vote_count: nil, release_date: nil, vote_average: nil))
        let alert = UIAlertController(title: "Movie", message: "Movie Downloaded", preferredStyle: .actionSheet)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .green.withAlphaComponent(0.2)
        alert.view.tintColor = .black
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
        
    }
    
}

extension MovieTrailerVC {
    
    
//    public func forDownload(with model: MovieData){
//        print("Download veri geldi", model)
//
//        DispatchQueue.main.async {
//            self.myArr = model
//        }
//    }
    
    public func configure(with model: YoutubeVM) {
        print("MODEL", model)
        titleLabel.text = model.title
        overview.text  = model.titleOverview

        //print("mymodel", model.youtubeView.id!.videoID!)
       
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
            webView.heightAnchor.constraint(equalToConstant:200),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            overview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            downloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBtn.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 25),
            downloadBtn.widthAnchor.constraint(equalToConstant: 140),
            downloadBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
