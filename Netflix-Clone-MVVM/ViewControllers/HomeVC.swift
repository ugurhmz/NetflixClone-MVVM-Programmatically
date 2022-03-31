//
//  HomeVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    let movieTypes: [String] = ["Trending Movie", "Popular", "Trendind TV", "UpComing Movies", "Top rated"]
    
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
        
        MovieWebService.shared.getTrendingMovies { _ in
            
        }
    }
    
    func setupViews() {
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
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 10,
                                         y: header.bounds.origin.y,
                                         width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
}


