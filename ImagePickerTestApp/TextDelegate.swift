//
//  TopTextDelegate.swift
//  ImagePickerTestApp
//
//  Created by Zach Eidenberger on 6/5/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import Foundation
import UIKit



class TextDelegate: NSObject, UITextFieldDelegate{
    
  
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
     textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TopTestDelegate > func textFieldShouldReturn")
        textField.resignFirstResponder()
        
        
        return true
    }
    
   
    
}
