//
//  HomeVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class HomeVC: UIViewController {

    
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
        return 5
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
    
    
}


