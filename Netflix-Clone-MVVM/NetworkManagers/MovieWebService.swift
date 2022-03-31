//
//  APIService.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 31.03.2022.
//

import Foundation
import Alamofire

enum MovieEndPoints: String {
    case baseURL = "https://api.themoviedb.org"
    case languageAndPage = "&language=en-US&page=1#"
    case movieAPI = "6fe8370265c396656c58d7dd9ff3e712"
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


public class MovieWebService: MovieWebServiceProtocol {
    
    static let shared = MovieWebService()
    
    
    public func getTrendingMovies(completion: @escaping (Result<MovieResponse>) -> Void) {
   
        let urlString = MovieEndPoints.baseURL.rawValue +
                        "/3/trending/movie/day?api_key=" +
                        MovieEndPoints.movieAPI.rawValue
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    print("response", response)
                    completion(.success(response))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
    }
    
    
    
}
