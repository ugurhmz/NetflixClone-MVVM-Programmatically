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
  
    func    getTrendingMovies(completion: @escaping (Result<[MovieData]>) -> Void )
    func    getTrendingTvs(completion: @escaping (Result<[MovieData]>) -> Void)
    func    getUpComingMovies(completion: @escaping (Result<[MovieData]>) -> Void)
    func    getPopular(completion: @escaping (Result<[MovieData]>) -> Void)
    func    getTopRated(completion: @escaping (Result<[MovieData]>) -> Void)

    
}


public class MovieWebService: MovieWebServiceProtocol {
 
    
    static let shared = MovieWebService()
  
    
    //MARK: - trendingMovies
    public func getTrendingMovies(completion: @escaping (Result<[MovieData]>) -> Void) {
   
        
        let urlString = MovieEndPoints.baseURL.rawValue +
                        "/3/trending/movie/day?api_key=" +
                        MovieEndPoints.movieAPI.rawValue
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                   
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
    }
    
    
    
    //MARK: - trending TVS
    public func getTrendingTvs(completion: @escaping (Result<[MovieData]>) -> Void) {
        
        let urlString = MovieEndPoints.baseURL.rawValue +
                        "/3/trending/tv/day?api_key=" +
                        MovieEndPoints.movieAPI.rawValue
        
        AF.request(urlString).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    print("result",response.results)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
                
            }
        }
    }
    
    //MARK: -  getPopular
    public func getPopular(completion: @escaping (Result<[MovieData]>) -> Void) {
        
        let urlString = MovieEndPoints.baseURL.rawValue +
                        "/3/movie/popular?api_key=" +
                        MovieEndPoints.movieAPI.rawValue
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                  
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
    }
    
    
    
    //MARK: - upComings
    public func getUpComingMovies(completion: @escaping (Result<[MovieData]>) -> Void) {
                
        let urlString = MovieEndPoints.baseURL.rawValue +
                       "/3/movie/upcoming?api_key=" +
                       MovieEndPoints.movieAPI.rawValue
       
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
            
        }
    }
    
    
    //MARK: - getTopRated
    public func getTopRated(completion: @escaping (Result<[MovieData]>) -> Void) {
        let urlString =  MovieEndPoints.baseURL.rawValue +
                         "/3/movie/top_rated?api_key=" +
                        MovieEndPoints.movieAPI.rawValue
        
        AF.request(urlString).responseData {  (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    
                    let response = try decoder.decode(MovieResponse.self, from: data)
                  //  print("-->",response.results)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
        
    }
   
    
}
