//
//  ListViewModel.swift
//  Marvel
//
//  Created by Mayur Rangari on 12/03/22.
//

import Foundation

class ListViewModel  {
    var httpUtility = HttpUtility()
    var marvelList: ListModel?
    
    typealias ComplitionBlock = (ListModel, Bool) -> Void
    //MARK: - Call Characters API
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: apiUrl, resultType: ListModel.self) { response in
                self.marvelList = response
                complitionBlock(response, true)
            }
        }
        else {
            complitionBlock(ListModel(code: 0, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: DataClass(offset: 0, limit: 0, total: 0, count: 0, results: [Result(id: 0, name: "", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 0, collectionURI: "", items: [ComicsItem(resourceURI: "", name: "")], returned: 0), series: Comics(available: 0, collectionURI: "", items: [ComicsItem(resourceURI: "", name: "")], returned: 0), stories: Stories(available: 0, collectionURI: "", items: [StoriesItem(resourceURI: "", name: "", type: .cover)], returned: 0), events: Comics(available: 0, collectionURI: "", items: [ComicsItem(resourceURI: "", name: "")], returned: 0), urls: [URLElement(type: .comiclink, url: "")])])) , false)
        }
    }
}
