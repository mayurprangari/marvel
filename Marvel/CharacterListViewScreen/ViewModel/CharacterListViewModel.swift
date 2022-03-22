//
//  ListViewModel.swift
//  Marvel
//
//  Created by Mayur Rangari on 12/03/22.
//

import Foundation

class CharacterListViewModel  {
    
    private var httpUtility = HttpUtility()
    private var marvelList: CharacterListModel?
    typealias ComplitionBlock = (CharacterListModel?, Bool) -> Void
    
    //MARK: - Call Characters API
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: apiUrl, resultType: CharacterListModel.self) {[weak self] response in
                self?.marvelList = response
                complitionBlock(response, true)
            }
        }
        else {
            complitionBlock(nil, false)
        }
    }
}
