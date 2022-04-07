//
//  DownloadViewModel.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 7.04.2022.
//

import Foundation

protocol DownloadViewModelProtocol {
    func downloadMovieWithIndexPath(sendHomeMovie: MovieData)
    var  downloadOutPut: DownloadOutPutProtocol? { get}
    
    func setDownloadDelegate(output: DownloadOutPutProtocol)
}


class DownloadViewModel: DownloadViewModelProtocol {
   
    var downloadOutPut: DownloadOutPutProtocol?
    
    
    func setDownloadDelegate(output: DownloadOutPutProtocol) {
        downloadOutPut = output
    }
    
    // download
    func downloadMovieWithIndexPath(sendHomeMovie: MovieData){
        DataPersistentManager.shared.downloadMovieConfigure(entityModel: sendHomeMovie) {  result in
            
            switch result {
            case .success():
                print("DOWNLOAD SUCCESS")
                NotificationCenter.default.post(name: NSNotification.Name("refreshTableView"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
     func  getLocalStorageDownloadDatas(){
        
             DataPersistentManager.shared.getDatasFromDB { [weak self] result in
                 switch result {
                 case .success(let movies):
                         self?.downloadOutPut?.saveData(downloadMovieValues: movies)
                    
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
        
    }
    
}
