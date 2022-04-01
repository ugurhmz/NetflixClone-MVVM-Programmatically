//
//  HomeViewModel.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 1.04.2022.
//

import Foundation


protocol HomeViewModelProcotol {
    func    getTrendingMovies()
    func    getTrendingTvs()
    func    getUpComingMovies()
    func    getPopular()
    func    getTopRated()
    
    
    var movieDataList: [MovieData] { get set }
    var movieWebService: MovieWebService { get }
    var movieOutPut: MovieOutPutProtocol? { get }
    
    func setDelegate(output: MovieOutPutProtocol)
}

final class HomeViewModel: HomeViewModelProcotol {
    
    
    var movieDataList: [MovieData] = []
    var movieWebService: MovieWebService
    var movieOutPut: MovieOutPutProtocol?
    
    
    init() {
        movieWebService = MovieWebService()
    }
    
    func setDelegate(output: MovieOutPutProtocol) {
        movieOutPut = output
    }
    
    
    
    func getTrendingMovies() {
        movieWebService.getTrendingMovies { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.movieOutPut?.saveTrendingMovies(movieValues: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTrendingTvs() {
        print("")
    }
    
    func getUpComingMovies() {
        print("")
    }
    
    func getPopular() {
        print("")
    }
    
    func getTopRated() {
        print("")
    }
    
}
