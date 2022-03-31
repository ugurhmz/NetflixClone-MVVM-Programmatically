//
//  MovieResponse.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 31.03.2022.
//

import Foundation



public struct MovieResponse: Codable {
    let results: [MovieData]
}

public struct MovieData: Codable {
    
    let id: Int
    let media_type: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let vote_average: Double?
}
