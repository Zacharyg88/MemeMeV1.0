//
//  TopTextDelegate.swift
//  MemeMeV1.0
//
//  Created by Zach Eidenberger on 6/5/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import Foundation
import UIKit



class TopTextDelegate: NSObject, UITextFieldDelegate{
    
   //static let viewController = ViewController()
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
     textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //ViewController.subscribeToHideKeyboardNotification()
        
        return true
    }
    
   
    
}
