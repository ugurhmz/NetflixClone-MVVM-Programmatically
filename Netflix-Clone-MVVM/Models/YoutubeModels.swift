// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - YoutubeMovieModel
public struct YoutubeMovieModel: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [YoutubeDataItem]?
  
}

// MARK: - Item
public struct YoutubeDataItem: Codable {
    let kind, etag: String?
    let id: ID?
}

// MARK: - ID
public struct ID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
        
    }
}

// MARK: - PageInfo
public struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
