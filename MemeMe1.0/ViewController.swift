//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Rick de Saussure on 5/15/17.
//  Copyright © 2017 Rick de Saussure. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var pickAnImageFromAlbum: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func pickAnImageFromAlbumButton(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)

  
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePickerView.image = image
            
            dismiss(animated: true, completion: nil)
            
            print("Test pickAlbum")
      }
        
    }
        
}

        

        



    

    

    
    



}

