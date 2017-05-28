//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Rick de Saussure on 5/15/17.
//  Copyright © 2017 Rick de Saussure. All rights reserved.
//

import UIKit

// MARK: Delegates

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate  {
    
// MARK: Outlets
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
// MARK: Textfield Perameters
    
    let memeFormText = [NSStrokeColorAttributeName: UIColor.black,
                        NSForegroundColorAttributeName: UIColor.white,
                        NSStrokeWidthAttributeName: -5,
                        NSKernAttributeName: 3,
                        NSFontAttributeName: UIFont (name: "HelveticaNEUE-CondensedBlack",size: 28)!]
                as [String: Any]
    
 
    

    
// MARK: Set Initial View
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        topText.text! = "TOP"
        topText.defaultTextAttributes = memeFormText
        topText.textAlignment = .center
    
    
        
        bottomText.text! = "BOTTOM"
        bottomText.defaultTextAttributes = memeFormText
        bottomText.textAlignment = .center
        
        
        
    }
    

    
    @IBAction func pickCamera(_ sender: Any) {
        
         pickImage(UIImagePickerControllerSourceType.camera)
    }
    
    
    @IBAction func pickAlbum(_ sender: Any) {
        
        pickImage(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    
    
   func pickImage(_ source: UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker,animated: true, completion: nil)
    }
    
 //   @objc(imagePickerController:didFinishPickingMediaWithInfo:)
    
    func imagePickerController (_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
}



