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
    @IBOutlet weak var sharebutton: UIButton?
    
    
    
    let topTextFieldDelegate = TopTextDelegate()
    let bottomTextFieldDelegate = BottomTextDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     camera?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Do any additional setup after loading the view, typically from a nib.
        self.topText?.defaultTextAttributes = memeTextAttributes
        self.topText?.textAlignment = .center
        self.topText?.delegate = topTextFieldDelegate
        self.bottomText?.defaultTextAttributes = memeTextAttributes
        self.bottomText?.textAlignment = .center
        self.bottomText?.delegate = bottomTextFieldDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        //subscribeToHideKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubcribeToKeyboardNotificaitons()
        //unsubscribeToHideKeyboardNotification()
    }
 
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: Float(-3.0)]



    @IBAction func pickfromAlbum (sender: AnyObject) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
    }
    @IBAction func pickfromCamera (sender: AnyObject) {
        let camerapicker = UIImagePickerController()
        camerapicker.delegate = self
        camerapicker.sourceType = .camera
        camerapicker.allowsEditing = false
        self.present(camerapicker, animated: true, completion: nil)
    }

    
    @IBAction func shareMeme (sender: AnyObject) {
        func generateMeme () -> (UIImage) {
            UIGraphicsBeginImageContext((self.imageView?.frame.size)!)
            view.drawHierarchy(in: (self.imageView?.frame)!, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return memedImage
        }
        var memedImage = generateMeme()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: [])
        self.show(activityController, sender: nil)

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("check")
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

        view.frame.origin.y = 0 - getKeyboardHeight(notification)
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
    
    
//    func generateMeme () -> UIImage {
//        UIGraphicsBeginImageContext((self.imageView?.frame.size)!)
//        view.drawHierarchy(in: (self.imageView?.frame)!, afterScreenUpdates: true)
//        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        return memedImage
//    }
//    func save() {
//        let meme = (toptext: topText?.text, bottomText: bottomText?.text, originalImage: imageView?.image, memedImage: generateMeme())
//    }

}

