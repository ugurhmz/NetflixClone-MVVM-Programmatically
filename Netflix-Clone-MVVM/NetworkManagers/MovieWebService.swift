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
    case YoutubeBase_URL = "https://youtube.googleapis.com/youtube/v3/search?"
    case YoutubeAPI_Key = "AIzaSyA0v2jybUPdoRSZitAu4en2Wq3q_n9oqNk"
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
    func    getDiscoverMovies(completion: @escaping (Result<[MovieData]>) -> Void)
    func    getSearch(with query: String, completion: @escaping (Result<[MovieData]>) -> Void)
    func    getYoutubeMovies(with query: String,
                             completion: @escaping (Result<YoutubeDataItem>) -> Void)
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
                 
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
        
    }
    
    
    //MARK: - discoverMovies
    public func getDiscoverMovies(completion: @escaping (Result<[MovieData]>) -> Void){
        let urlString = MovieEndPoints.baseURL.rawValue +
                        "/3/discover/movie?api_key=" +
                        MovieEndPoints.movieAPI.rawValue + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
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
    
    
    //MARK: - getSearch
    public func getSearch(with query: String,
                          completion: @escaping (Result<[MovieData]>) -> Void) {
       
       guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return}
       let urlString =  MovieEndPoints.baseURL.rawValue +
                        "/3/search/movie?api_key=" +
                        MovieEndPoints.movieAPI.rawValue +
                        "&query=\(query)"
        
        
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
    
    
    //MARK: - Youtube getMovie
    public func getYoutubeMovies(with query: String,
                                 completion: @escaping (Result<YoutubeDataItem>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return}
       
        let urlString = MovieEndPoints.YoutubeBase_URL.rawValue +
        "q=\(query)&key=" + MovieEndPoints.YoutubeAPI_Key.rawValue
        
        AF.request(urlString).responseData { (response) in
           
        
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder

                do {
                    let response = try decoder.decode(YoutubeMovieModel.self, from: data)
                    print(response)
                    guard let responseItem = response.items?[0] else {
                        print("Theres is Problem with Yotuube API!, change Youtube API_KEY")
                        return
                    }
                    
                    completion(.success(responseItem))
                    
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
                
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
            }
        }
    
}

    
