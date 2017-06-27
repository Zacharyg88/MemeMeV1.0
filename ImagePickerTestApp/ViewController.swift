//
//  ViewController.swift
//  ImagePickerTestApp
//
//  Created by Zach Eidenberger on 5/31/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var picker: UIBarButtonItem?
    @IBOutlet weak var camera: UIBarButtonItem?
    @IBOutlet weak var topText: UITextField?
    @IBOutlet weak var bottomText: UITextField?
    @IBOutlet weak var sharebutton: UIBarButtonItem?
    @IBOutlet weak var toolbar: UIToolbar?
    
    
    
    
    let TextFieldDelegate = TextDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        func configure (textfield: UITextField) {
            textfield.defaultTextAttributes = memeTextAttributes
            textfield.textAlignment = .center
            textfield.delegate = TextFieldDelegate
        }
        configure(textfield: topText!)
        configure(textfield: bottomText!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubcribeToKeyboardNotificaitons()
        
    }
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: Float(-3.0)]
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
    var memeArray = [Meme]()
    
    func chooseSourceType(source: UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        if source == .camera {
            picker.sourceType = .camera
        }
        if source == .photoLibrary {
            picker.sourceType = .photoLibrary
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func pickfromAlbum (sender: AnyObject) {
        chooseSourceType(source: .photoLibrary)
    }
    @IBAction func pickfromCamera (sender: AnyObject) {
        chooseSourceType(source: .camera)
    }
    
    
    @IBAction func shareMeme (sender: AnyObject) {
        func generateMeme () -> (UIImage) {
            toolbar?.isHidden = true
            //            sharebutton?.isHidden = true
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: (self.view.frame), afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            toolbar?.isHidden = false
            //sharebutton?.isHidden = false
            
            print(memeArray)
            
            return memedImage
        }
        
        let memedImage = generateMeme()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: [])
        self.show(activityController, sender: nil)
        
        
        
        
        
        activityController.completionWithItemsHandler = {(type: UIActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            
            self.memeArray.append(Meme(topText: (self.topText?.text!)!, bottomText: (self.bottomText?.text!)!, originalImage: (self.imageView?.image!)!, memedImage: memedImage))
            print(self.memeArray)
            
            
        }
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView?.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    // Show Keyboard
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if (topText?.isEditing)! {
            view.frame.origin.y = 0.0
        }else {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide (_ notification: Notification) {
        
        view.frame.origin.y = 0.0
    }
    
    
    
    func subscribeToKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubcribeToKeyboardNotificaitons () {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
}

