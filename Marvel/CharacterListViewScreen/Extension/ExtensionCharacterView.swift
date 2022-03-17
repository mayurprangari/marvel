//
//  ExtensionCharacterView.swift
//  Marvel
//
//  Created by Mayur Rangari on 15/03/22.
//

import Foundation
import UIKit

//MARK: - Loader for List Controller
extension CharacterListViewController {
    func loadSpinnerView() {
        // add the spinner view controller
        addChild(child)
        child.view.frame = UIScreen.main.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func removeSpinnerView() {
        // remove the spinner view controller
        self.child.willMove(toParent: nil)
        self.child.view.removeFromSuperview()
        self.child.removeFromParent()
    }
}

