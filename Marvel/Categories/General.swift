//
//  General.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import Foundation
import UIKit
let SCREEN_WIDTH    =   UIScreen.main.bounds.size.width
let SCREEN_HEIGHT   =   UIScreen.main.bounds.size.height
let app_del         =   UIApplication.shared.delegate as! AppDelegate
let IS_IPHONE_5S     =  SCREEN_HEIGHT == 568.0
let IS_IPHONE_X     =   (UIScreen.main.bounds.size.height >= 812.0)
let MAIN_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)



