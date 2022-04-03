//
//  SearchVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

protocol SearchMovieOutPutProtocol{
    func saveSearchMovies(movieValues: [MovieData])
    func saveSearchingResultList(movieValues: [MovieData])
}


class SearchVC: UIViewController {

    private var searchMovieList: [MovieData] = [MovieData]()
    private var resultSearchList: [MovieData] = []
    lazy var viewModel = SearchViewModel()
    
    
    
    private let searchTableView: UITableView = {
        let table = UITableView()
        table.register(UpComingTableViewCell.self,
                       forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return table
    }()
    
    
    // SearchBar'da yazınca çıkması istenilen ViewControllerı burda veriyoruz.
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsController())
        controller.searchBar.placeholder = "Searching.."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModelDelegate()
        searchController.searchResultsUpdater = self
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
        searchTableView.reloadData()
    }
    
    func saveSearchingResultList(movieValues: [MovieData]) {
        self.resultSearchList = movieValues
        print("resultSearchList",resultSearchList)
        
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


//MARK: - SearchResult
extension SearchVC: UISearchResultsUpdating {


    func updateSearchResults(for searchController: UISearchController) {

        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
               query.trimmingCharacters(in: .whitespaces).count >= 3,
              
                let resultsController = searchController.searchResultsController as? SearchResultsController else { return}
        
        viewModel.getSearch(with: query)
        resultsController.resultList = resultSearchList
        resultsController.searchResultCollectionView.reloadData()
        
//        MovieWebService.shared.getSearch(with: query) { result in
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let movie):
//                    resultsController.resultList = movie
//                    resultsController.searchResultCollectionView.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }

    }

}
