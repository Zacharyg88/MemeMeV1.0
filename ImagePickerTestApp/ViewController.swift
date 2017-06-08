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
 
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: Float(-3.0)]


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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


}

