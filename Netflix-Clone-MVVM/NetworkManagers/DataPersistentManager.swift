//
//  DataPersistentManager.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 6.04.2022.
//

import Foundation
import UIKit
import CoreData


class DataPersistentManager {
    
    enum DataBaseError {
        case failedSaveData
        case fetchDBerror
        case deletedDBError
    }
    
    static let shared = DataPersistentManager()
    
    
    func getContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
           
            return  NSManagedObjectContext()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    
    
    // SAVE
    func downloadMovieConfigure(entityModel: MovieData,
                                completion: @escaping (Result<Void>) -> Void)
    {
        
        
        let myMovieModel = MovieEntity(context: getContext())
        
        myMovieModel.id = Int64(entityModel.id)
        myMovieModel.original_name = entityModel.original_name
        myMovieModel.title = entityModel.title
        myMovieModel.poster_path = entityModel.poster_path
        myMovieModel.media_type = entityModel.media_type
        myMovieModel.release_date = entityModel.release_date
        myMovieModel.vote_count = Int32(entityModel.vote_count ?? 0)
        myMovieModel.vote_average = Double(entityModel.vote_average ?? 0)
        
        do {
            try getContext().save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedSaveData as! Error))
        }
    }
    
    
    // GET ALL
    func getDatasFromDB(completion: @escaping (Result<[MovieEntity]>) -> Void){
       
            let request: NSFetchRequest<MovieEntity>
            
            request = MovieEntity.fetchRequest()
            
            do {
                
                let movieDatas = try self.getContext().fetch(request)
                
                
                completion(.success(movieDatas))
                
            } catch {
                completion(.failure(DataBaseError.fetchDBerror as! Error))
            }
          
    }
    
    //Delete
    func deleteDataFromDB(entityModel: MovieEntity,
                          completion: @escaping (Result<Void>) -> Void) {
        
        getContext().delete(entityModel)
        
        do {
            try getContext().save()
            completion(.success(()))
            
        } catch {
            completion(.failure(DataBaseError.deletedDBError as! Error))
        }
        
    }
    
}
