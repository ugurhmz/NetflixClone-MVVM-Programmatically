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
        table.register(TableCollectionViewCell.self,
                       forCellReuseIdentifier: TableCollectionViewCell.identifier)
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
        
        searchTableView.frame = view.bounds
        
    }
    
    private func viewModelDelegate(){
        viewModel.setSearchDelegate(output: self)
        viewModel.getDiscoverMovies()
    }

}

extension SearchVC: SearchMovieOutPutProtocol {
    
    
    func saveSearchMovies(movieValues: [MovieData]) {
        self.searchMovieList = movieValues
        print("searchresult", movieValues)
        searchTableView.reloadData()
    }
    
}
