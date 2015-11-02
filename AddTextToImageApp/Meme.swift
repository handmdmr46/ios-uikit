//
//  Meme.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject, NSCoding {
    
    // MARK: struct, constants
    
    struct Keys {
        static let TopTextKey = "top_text_key"
        static let BottomTextKey = "bottom_text_key"
        static let ImageKey = "image_key"
        static let MemeImageKey = "meme_image_key"
    }
    
    // MARK: properties
    
    var topText: String
    var bottomText: String
    var image: UIImage!
    var memeImage: UIImage!
    
    init(topText: String, bottomText: String, image: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
    
    // MARK: - NSCoding, needed so we can save objects to NSUserDefaults
    
    /*
    ** archive the information inside the Meme, one property at a time
    */
    func encodeWithCoder(archiver: NSCoder) {
        
        archiver.encodeObject(topText, forKey: Keys.TopTextKey)
        archiver.encodeObject(bottomText, forKey: Keys.BottomTextKey)
        archiver.encodeObject(image, forKey: Keys.ImageKey)
        archiver.encodeObject(memeImage, forKey: Keys.MemeImageKey)
    }
    
    /*
    ** un-archive the data, one property at a time
    */
    required init(coder unarchiver: NSCoder) {

        topText = unarchiver.decodeObjectForKey(Keys.TopTextKey) as! String
        bottomText = unarchiver.decodeObjectForKey(Keys.BottomTextKey) as! String
        image = unarchiver.decodeObjectForKey(Keys.ImageKey) as! UIImage
        memeImage = unarchiver.decodeObjectForKey(Keys.MemeImageKey) as! UIImage
        
        super.init()
    }
}