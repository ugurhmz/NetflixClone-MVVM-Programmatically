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
        NotificationCenter.default.addObserver(forName: NSNotification.Name("refreshTableView"), object: nil, queue: nil) { _ in
            print("NotificationCenter")
            self.tableView.reloadData()
        }
       
    }
   
    
    private func setupViews(){
        
         view.addSubview(tableView)
         tableView.frame = view.bounds
         tableView.delegate = self
         tableView.dataSource = self
        
        viewModel.setDownloadDelegate(output: self)
        self.viewModel.getLocalStorageDownloadDatas()
     
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "trash.slash"), style: .done,
                            target: self, action: #selector(deleteAllDownloaded))]
        navigationController?.navigationBar.tintColor = .red
      
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        viewModel.getLocalStorageDownloadDatas()
        self.tableView.reloadData()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        viewModel.getLocalStorageDownloadDatas()
//        self.tableView.reloadData()
//    }
    
    
    @objc func deleteAllDownloaded(){
        DataPersistentManager.shared.deleteAllFromDB()
        DispatchQueue.main.async {
            self.viewModel.getLocalStorageDownloadDatas()
            self.tableView.reloadData()
        }
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
            print("fetching", downloadMovieValues)
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
    
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            DataPersistentManager.shared.deleteDataFromDB(entityModel: downloadedMovieList[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.downloadedMovieList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
    
}



