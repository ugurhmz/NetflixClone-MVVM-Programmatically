//
//  UpComingVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class UpComingVC: UIViewController {
    
    private var movieUpComingList: [MovieData] = [MovieData]()
    
    private let upComingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
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
        
        fetchDatas()
    }
    
    private func fetchDatas(){
        MovieWebService.shared.getUpComingMovies { result in
            switch result {
            case .success(let movie):
                self.movieUpComingList = movie
                print(movie)
                DispatchQueue.main.async {
                    self.upComingTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

extension UpComingVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movieUpComingList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = movieUpComingList[indexPath.row].title
        return cell
    }
    
    
}
