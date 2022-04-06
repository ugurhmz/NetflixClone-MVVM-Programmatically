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
    }
    
    static let shared = DataPersistentManager()
    
    
    func downloadMovieConfigure(entityModel: MovieData,
                                completion: @escaping (Result<Void>) -> Void)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let myMovieModel = MovieEntity(context: context)
        
        myMovieModel.id = Int64(entityModel.id)
        myMovieModel.original_name = entityModel.original_name
        myMovieModel.title = entityModel.title
        myMovieModel.poster_path = entityModel.poster_path
        myMovieModel.media_type = entityModel.media_type
        myMovieModel.release_date = entityModel.release_date
        myMovieModel.vote_count = Int32(entityModel.vote_count ?? 0)
        myMovieModel.vote_average = Double(entityModel.vote_average ?? 0)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedSaveData as! Error))
        }
    }
}
