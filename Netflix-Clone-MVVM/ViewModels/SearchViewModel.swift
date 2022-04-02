//
//  SearchViewModel.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 2.04.2022.
//

import Foundation

protocol SearchViewModelProtocol {
    func getDiscoverMovies()
    func setSearchDelegate(output: SearchMovieOutPutProtocol)
    var searchOutPut: SearchMovieOutPutProtocol? { get }
}



final class SearchViewModel: SearchViewModelProtocol  {
    var searchOutPut: SearchMovieOutPutProtocol?
    var movieWebService : MovieWebService
    
    
    init(){
        movieWebService = MovieWebService()
    }
    
    
    // setDelegate
    func setSearchDelegate(output: SearchMovieOutPutProtocol) {
        searchOutPut = output
    }
    
    
    // getDiscover
    func getDiscoverMovies(){
        movieWebService.getDiscoverMovies { [weak self] (result) in
            guard let self = self else {return }
            
            switch result {
            case .success(let response):
                self.searchOutPut?.saveSearchMovies(movieValues: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
