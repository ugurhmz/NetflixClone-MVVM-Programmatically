//
//  DownloadVC.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit


protocol DownloadOutPutProtocol {
    func saveData(downloadMovieValues: [MovieEntity])
}


class DownloadVC: UIViewController {

    
    private var downloadedMovieList = [MovieEntity]()
    lazy var viewModel = DownloadViewModel()
    var refreshControl = UIRefreshControl()
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UpComingTableViewCell.self,
                    forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSettings()
        setupViews()
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("refreshTableView"), object: nil, queue: nil) { _ in
//            print("NotificationCenter")
//          
//            let vm = DownloadViewModel()
//            vm.getLocalStorageDownloadDatas()
//            self.tableView.reloadData()
//            
//        }
       
    }
   
    
    private func setupViews(){
        
         view.addSubview(tableView)
         tableView.frame = view.bounds
         tableView.delegate = self
         tableView.dataSource = self
        
        viewModel.setDownloadDelegate(output: self)
        self.viewModel.getLocalStorageDownloadDatas()
     
        
    }
    
    
    
    private func navigationSettings(){
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
}


//MARK: -
extension DownloadVC: DownloadOutPutProtocol {
    
    func saveData(downloadMovieValues: [MovieEntity]) {
        self.downloadedMovieList = downloadMovieValues
        print("fetchin oldu", downloadMovieValues)
        self.tableView.reloadData()
    }
    
    
}




//MARK: -
extension DownloadVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return  downloadedMovieList.count
    }
    
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as! UpComingTableViewCell
    
        cell.configureMovieEntity(movie: downloadedMovieList[indexPath.row] )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}



