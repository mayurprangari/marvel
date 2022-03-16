//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Mayur Rangari on 13/03/22.
//

import Foundation

class ComicsViewModel {
    var httpUtility = HttpUtility()
    var comicList: ComicsModel?
    
    typealias ComplitionBlock = (ComicsModel, Bool) -> Void
    //MARK: - Call Comics API
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: apiUrl, resultType: ComicsModel.self) { response in
                self.comicList = response
                complitionBlock(response, true)
            }
        }
        else {
            complitionBlock(ComicsModel(code: 0, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: DataClasses(offset: 0, limit: 0, total: 0, count: 0, results: [Results(id: 0, digitalID: 0, title: "", issueNumber: 0, resultDescription: "", thumbnail: Thumbnails(path: "", thumbnailExtension: ""), images: [Thumbnails(path: "", thumbnailExtension: "")])])) , false)
        }
    }
}
