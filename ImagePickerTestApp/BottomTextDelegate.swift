//
//  BottomTextDelegate.swift
//  ImagePickerTestApp
//
//  Created by Zach Eidenberger on 6/5/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import Foundation
import UIKit

class BottomTextDelegate: NSObject, UITextFieldDelegate {
    
    static let viewController = ViewController()
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("BottomTextDelegate > func textFieldShouldReturn")
        textField.resignFirstResponder()
        //BottomTextDelegate.viewController.subscribeToHideKeyboardNotification()
        
        
        return true
    }
    
}
