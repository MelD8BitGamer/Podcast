//
//  UIViewControllerExtensions.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/18/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation
import UIKit
//this has to be the CLASS NOT subclass. YOu use this to use in ANY project necessary as a separate file
extension UIViewController {
    //completion handler is not really necessary, it to dismiss a view controller after the user presses OK. we have access to this every ViewController
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )//style means segue style the transition from one slide to the other. look up more later// a handle is a bloc that execute when the user select an action. it is already equal to nil
        let okAction = UIAlertAction(title: "OK" , style: .default, handler: completion )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
