//
//  HomeVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTv = 2
    case UpComingMovies = 3
    case TopRated = 4
}



protocol MovieOutPutProtocol {
    func saveTrendingMovies(movieValues: [MovieData])
    func saveTrendingTvs(movieValues: [MovieData])
    func savePopularMovies(movieValues: [MovieData])
    func saveUpComingMovies(movieValues: [MovieData])
    func saveTopRatedMovies(movieValues: [MovieData])
}

class HomeVC: UIViewController {
    
    private lazy var homeTrendingList: [MovieData] = []
    private lazy var homeTrendingTvList: [MovieData] = []
    private lazy var homePopularMovieList: [MovieData] = []
    private lazy var homeUpComingMovieList: [MovieData] = []
    private lazy var homeTopRatedMovieList: [MovieData] = []
    
    lazy var viewModel = HomeViewModel()
    
    
    let movieTypes: [String] = ["Trending Movie", "Popular", "Trending TV", "UpComing Movies", "Top rated"]
    
    // homeTableView
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        // register
        tableView.register(TableCollectionViewCell.self,
                           forCellReuseIdentifier: TableCollectionViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModelDelegate()
        
        
        MovieWebService.shared.getYoutubeMovies(with: "harry") { result in
            
        }
   
//        navigationController?.pushViewController(MovieTrailerVC(), animated: true)
    }
    
    private func viewModelDelegate(){
        
        //viewModel delegate
        viewModel.setDelegate(output: self)
        viewModel.getTrendingMovies()
        viewModel.getTrendingTvs()
        viewModel.getPopular()
        viewModel.getUpComingMovies()
        viewModel.getTopRated()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        // header view settings
        let headerView = TopHeaderUIView(frame: CGRect(x: 0, y: 0,
                                                       width: view.bounds.width,
                                                       height: 450))
        homeTableView.tableHeaderView = headerView
        homeTableView.frame = view.bounds
        
        settingsNavigateBar()
    }
    
    
    func settingsNavigateBar(){
        let netflixImage = UIImage(named: "netflixIcon")?.withRenderingMode(.alwaysOriginal)
        
        // left icon
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: netflixImage, style: .done,
                                                           target: self, action: nil)
        // right two icons
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done,
                            target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                            style: .done, target: self, action: nil)
        ]
        
        
        // icons color
        navigationController?.navigationBar.tintColor = .white
        
    }
   
  

}



//MARK: - MovieOutPutProtocol
extension HomeVC: MovieOutPutProtocol {
   
    
    // trendingMovies
    func saveTrendingMovies(movieValues: [MovieData]) {
        self.homeTrendingList = movieValues
        homeTableView.reloadData()
    }
    
    // popular
    func savePopularMovies(movieValues: [MovieData]) {
        self.homePopularMovieList = movieValues
        homeTableView.reloadData()
    }
    
    
    // trending TVs
    func saveTrendingTvs(movieValues: [MovieData]) {
        self.homeTrendingTvList = movieValues
        homeTableView.reloadData()
    }
    
    
    // upComingMovies
    func saveUpComingMovies(movieValues: [MovieData]) {
        self.homeUpComingMovieList = movieValues
        homeTableView.reloadData()
    }
    
    
    // topRatedMovies
    func saveTopRatedMovies(movieValues: [MovieData]) {
        self.homeTopRatedMovieList = movieValues
        homeTableView.reloadData()
    }
    
    
}





//MARK: - TableView Delegate, DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    // alt alta hücre sayısı
    func numberOfSections(in tableView: UITableView) -> Int {
        return  movieTypes.count
    }
    
    
    
    
    // hücre içi
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    // cellForRowAt
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        
        tableCell.youtubeDelegate = self
        
        
        // switch sections
        switch indexPath.section {
            
        case Sections.TrendingMovies.rawValue:
            tableCell.configure(with: homeTrendingList)
            
        case Sections.Popular.rawValue:
            tableCell.configure(with: homePopularMovieList)

        case Sections.TrendingTv.rawValue:
            tableCell.configure(with: homeTrendingTvList)

        case Sections.UpComingMovies.rawValue:
            tableCell.configure(with: homeUpComingMovieList)

        case Sections.TopRated.rawValue:
            tableCell.configure(with: homeTopRatedMovieList)
                 
           
            default:
                return UITableViewCell()
        }
        
        return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX:  0,
                                                              y: min(0, -offset))
    }
    
    
    // Header Title
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return movieTypes[section]
    }
    
    
    // Header Title Settings
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 2,
                                         y: header.bounds.origin.y ,
                                         width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
}



//MARK: -
extension HomeVC: TableCollectionViewCellProtocol {
    
    func tableCollectionViewCellDidTapCell(_ cell: TableCollectionViewCell,
                                           youtubeVM: YoutubeVM) {
        
        print("click")
        DispatchQueue.main.async { [weak self] in
            let vc = MovieTrailerVC()
            vc.configure(with: youtubeVM)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
