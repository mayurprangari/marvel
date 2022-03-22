//
//  String.swift
//  Marvel
//
//  Created by Mayur Rangari on 12/03/22.
//

import Foundation
import UIKit

//MARK: - For verify URL
extension String {
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
