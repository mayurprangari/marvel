//
//  Constant.swift
//  Marvel
//
//  Created by Mayur Rangari on 12/03/22.
//

import Foundation
import UIKit

//MARK: - Set Constant URL
struct Constants {    
    static let baseUrl: String = "https://gateway.marvel.com"
    static let ts: String = "thesoer"
    static let apiKey = "001ac6c73378bbfff488a36141458af2"
    static let hashKey = "72e5ed53d1398abb831c3ceec263f18b"
    static let charactersAPI: String = "https://gateway.marvel.com/v1/public/characters?ts=thesoer&apikey=001ac6c73378bbfff488a36141458af2&hash=72e5ed53d1398abb831c3ceec263f18b"
    static let comicsAPI1: String = "https://gateway.marvel.com/v1/public/characters/"
    static let comicsAPI2: String = "/comics?ts=thesoer&apikey=001ac6c73378bbfff488a36141458af2&hash=72e5ed53d1398abb831c3ceec263f18b"
    static let messageBody: String = "Internet Connection not Available!"
}


