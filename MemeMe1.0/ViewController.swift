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
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
// MARK: Textfield Perameters
    
    let memeFormText = [NSStrokeColorAttributeName: UIColor.black,
                        NSForegroundColorAttributeName: UIColor.white,
                        NSStrokeWidthAttributeName: -5,
                        NSKernAttributeName: 3,
                        NSFontAttributeName: UIFont (name: "HelveticaNEUE-CondensedBlack",size: 28)!]
                as [String: Any]

    
// MARK: Set Initial View Top and Bottom Formated Text
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        imagePickerView.image = nil

        topText.text! = "TOP"
        topText.defaultTextAttributes = memeFormText
        topText.textAlignment = .center
        topText.delegate = self
    
        bottomText.text! = "BOTTOM"
        bottomText.defaultTextAttributes = memeFormText
        bottomText.textAlignment = .center
        bottomText.delegate = self
        
        imagePickerView.image = nil

    }
    
    
    
// MARK: Camera and Album Button Actions
    
    @IBAction func pickCamera(_ sender: Any) {
        
         pickImage(UIImagePickerControllerSourceType.camera)
    }
    
    
    @IBAction func pickAlbum(_ sender: Any) {
        
        pickImage(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    
// MARK: Setup Keyboard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    func subscribeToKeyboardNotifications() {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
        name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
        name: .UIKeyboardWillHide, object: nil)
    }
     
     func keyboardWillShow(_ notification:Notification) {
        
        if bottomText.isFirstResponder && view.frame.origin.y == 0 {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
     }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        if bottomText.isFirstResponder && view.frame.origin.y != 0 {
        view.frame.origin.y = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    

     func unsubscribeFromKeyboardNotifications() {
     
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (topText.text == "TOP" || bottomText.text == "BOTTOM") {

            topText.text = ""
            bottomText.text = ""
            
            shareButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        return true
    }

// MARK: Image Picker Functions
    
   func pickImage(_ source: UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker,animated: true, completion: nil)
    }
    
    
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
    
    
//MARK: Cancel Button
    
   @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        viewDidLoad()
    }
    
    
    
//MARK: Save Meme
    
    func saveMeme(_ memedImage: UIImage) {

     _ = (topText: topText.text!, bottomText: bottomText.text!, originalImage:
        imagePickerView.image!, memedImage: memedImage)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        navigationBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        navigationBar.isHidden = false
        
        return memedImage
        
    }

//MARK: Share Meme
 
    @IBAction func shareImage(_ sender: UIBarButtonItem) {

        
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems:
            [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, completed, items, error in if completed{
                self.saveMeme(memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        

        
        present(activityController, animated: true, completion: nil)
        
    }
 
}



