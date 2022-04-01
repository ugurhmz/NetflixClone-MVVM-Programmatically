//
//  UpComingVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit



class UpComingVC: UIViewController {
    
    private var movieUpComingList: [MovieData] = []
    private lazy var homeTrendingList: [MovieData] = []
    private lazy var homeTrendingTvList: [MovieData] = []
    private lazy var homePopularMovieList: [MovieData] = []
    private lazy var upComingVCUpComingMovieList: [MovieData] = []
    private lazy var homeTopRatedMovieList: [MovieData] = []
    
    lazy var viewModel = HomeViewModel()
    
    private let upComingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpComingTableViewCell.self,
                           forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "UpComing"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        
        [upComingTableView].forEach { view.addSubview($0)}
        
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        
        upComingTableView.frame = view.bounds
        viewModelDelegate()
    }
    
    private func viewModelDelegate(){
        viewModel.setDelegate(output: self)
        viewModel.getUpComingMovies()
    }
    

}


//MARK: - Protocol
extension UpComingVC: MovieOutPutProtocol {
    
    
    // trendingMovies
    func saveTrendingMovies(movieValues: [MovieData]) {
        self.homeTrendingList = movieValues
        upComingTableView.reloadData()
    }
    
    // popular
    func savePopularMovies(movieValues: [MovieData]) {
        self.homePopularMovieList = movieValues
        upComingTableView.reloadData()
    }
    
    
    // trending TVs
    func saveTrendingTvs(movieValues: [MovieData]) {
        self.homeTrendingTvList = movieValues
        upComingTableView.reloadData()
    }
    
    
    // upComingMovies
    func saveUpComingMovies(movieValues: [MovieData]) {
        self.upComingVCUpComingMovieList = movieValues
        upComingTableView.reloadData()
    }
    
    
    // topRatedMovies
    func saveTopRatedMovies(movieValues: [MovieData]) {
        self.homeTopRatedMovieList = movieValues
        upComingTableView.reloadData()
    }
     
    
}


//MARK: - Delegate, DataSource
extension UpComingVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return upComingVCUpComingMovieList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else {
            return UITableViewCell()
        }
       
       
        cell.configure(movie: upComingVCUpComingMovieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    
}
