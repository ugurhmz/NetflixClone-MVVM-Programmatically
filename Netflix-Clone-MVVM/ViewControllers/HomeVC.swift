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
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
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
        
        homeTableView.frame = view.bounds
    }
  

}


//MARK: - TableView Delegate, DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    
    // cellForRowAt
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath)
        
        cell.textLabel?.text =  "Test\(indexPath.row)"
        cell.backgroundColor =  indexPath.row % 2  == 0 ? .green : .red
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}


