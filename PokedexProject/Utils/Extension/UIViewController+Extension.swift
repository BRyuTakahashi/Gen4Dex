//
//  UIViewController+Extension.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 07/06/26.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
