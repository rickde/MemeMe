//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Rick de Saussure on 5/15/17.
//  Copyright © 2017 Rick de Saussure. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    }


}

