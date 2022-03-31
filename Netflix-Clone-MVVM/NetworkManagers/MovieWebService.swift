//
//  APIService.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 31.03.2022.
//

import Foundation


public enum MovieEndPoints: String {
    case apiBaseUrl = "https://api.themoviedb.org"
    case languageAndPage = "&language=en-US&page=1#"
    case myAPIKey = "6fe8370265c396656c58d7dd9ff3e712"
}


public enum APIError: Swift.Error {
    case serializationError(internal: Swift.Error)
    case networkError(internal: Swift.Error)
}



public protocol MovieWebServiceProtocol {
    
    func    getTrendingMovies(completion: @escaping (Result<MovieResponse>) -> Void )
//    func    getTrendingTvs()
//    func    getUpComingMovies()
//    func    getPopular()
//    func    getTopRated()
//    func    getDiscoverMovies()
    //search
    
    //getMovie
    
}


public class MovieWebService {
    
    
   
    
}
