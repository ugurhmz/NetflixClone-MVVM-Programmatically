//
//  SearchVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

protocol SearchMovieOutPutProtocol{
    func saveSearchMovies(movieValues: [MovieData])
}


class SearchVC: UIViewController {

    private var searchMovieList: [MovieData] = [MovieData]()
    lazy var viewModel = HomeViewModel()
    
    
    
    private let searchTableView: UITableView = {
        let table = UITableView()
        table.register(UpComingTableViewCell.self,
                       forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return table
    }()
    
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsController())
        controller.searchBar.placeholder = "Searching.."
        return controller
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModelDelegate()
    }
    
    private func setupViews() {
        view.addSubview(searchTableView)
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.frame = view.bounds
    }
    
    private func viewModelDelegate(){
        viewModel.setSearchDelegate(output: self)
        viewModel.getDiscoverMovies()
    }

}


//MARK: -
extension SearchVC: SearchMovieOutPutProtocol {
    
    func saveSearchMovies(movieValues: [MovieData]) {
        self.searchMovieList = movieValues
        print("searchresult", movieValues)
        searchTableView.reloadData()
    }
}


//MARK: - Delegate, DataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return searchMovieList.count
    }
    
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchCell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as! UpComingTableViewCell
    
        searchCell.configure(movie: searchMovieList[indexPath.row])
        
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
