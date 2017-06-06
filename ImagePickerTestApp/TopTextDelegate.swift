//
//  TopTextDelegate.swift
//  ImagePickerTestApp
//
//  Created by Zach Eidenberger on 6/5/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import Foundation
import UIKit

class TopTextDelegate: NSObject, UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
     textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
