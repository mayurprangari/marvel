//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Mayur Rangari on 13/03/22.
//

import Foundation

class ComicsViewModel {
    
    private var httpUtility = HttpUtility()
    private var comicList: ComicsModel?
    typealias ComplitionBlock = (ComicsModel?, Bool) -> Void
    
    //MARK: - Call Comics API
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: apiUrl, resultType: ComicsModel.self) {[weak self] response in
                self?.comicList = response
                complitionBlock(response, true)
            }
        }
        else {
            complitionBlock(nil, false)
        }
    }
}
