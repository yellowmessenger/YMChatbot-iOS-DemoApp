//
//  Helper.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 15/09/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showInfoAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
