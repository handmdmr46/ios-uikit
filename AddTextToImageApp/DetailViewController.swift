//
//  DetailViewController.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var bottomMessage: UITextField!
    @IBOutlet weak var topMessage: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        topMessage.text = meme.topText
        bottomMessage.text = meme.bottomText
        imageView.contentMode = .ScaleAspectFill
        imageView.image = meme.memeImage
    }
    
}
