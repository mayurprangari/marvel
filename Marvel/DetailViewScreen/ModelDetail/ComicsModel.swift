//
//  ComicsModel.swift
//  Marvel
//
//  Created by Mayur Rangari on 13/03/22.
//
//
import Foundation
//
// MARK: - Temperatures
struct ComicsModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: DataClasses?
}

// MARK: - DataClass
struct DataClasses: Codable {
    var offset, limit, total, count: Int?
    var results: [Results]?
}

// MARK: - Result
struct Results: Codable {
    var id, digitalID: Int?
    var title: String?
    var issueNumber: Int?
    var resultDescription: String?
    var thumbnail: Thumbnails?
    var images: [Thumbnails]?
  

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID
        case title, issueNumber
        case resultDescription
        case thumbnail, images
    }
}

// MARK: - Thumbnail
struct Thumbnails: Codable {
    var path: String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension
    }
}
