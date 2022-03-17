//
//  HttpUtility.swift
//  Marvel
//
//  Created by Mayur Rangari on 12/03/22.
//

import Foundation
import UIKit

//MARK: - For API request service
struct HttpUtility {
    func getApiData<T: Decodable>(requestUrl: String, resultType: T.Type, completionHandler:@escaping(_ result: T) -> Void) {
        if Common.verifyUrl(urlString: requestUrl) {
            if let requestApiUrl = URL(string: requestUrl) {
                URLSession.shared.dataTask(with: requestApiUrl) { responseData, httpUrlResponse, error in
                    if error == nil && httpUrlResponse != nil {
                        if let responseData = responseData {
                            if let dataString = String(data: responseData, encoding: .isoLatin1) {
                                let jsonData = dataString.data(using: .utf8)!
                                let decoder = JSONDecoder()
                                do {
                                    let result = try decoder.decode(T.self, from: jsonData)
                                    _ = completionHandler(result)
                                }
                                catch let error {
                                    debugPrint(error.localizedDescription)
                                }
                            }
                        }
                    }else{
                        app_del.showToast(message: error?.localizedDescription ?? "Server Error")
                    }
                }
                .resume()
            }else{
                print("URL not created")
            }
        }else{
            print("Invalid URL")
        }
    }
}
