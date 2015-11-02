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
    
    struct Keys {
        static let TopTextKey = "top_text_key"
        static let BottomTextKey = "bottom_text_key"
        static let ImageKey = "image_key"
        static let MemeImageKey = "meme_image_key"
    }
    
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
    
    func encodeWithCoder(archiver: NSCoder) {
        
        // archive the information inside the Meme, one property at a time
        archiver.encodeObject(topText, forKey: Keys.TopTextKey)
        archiver.encodeObject(bottomText, forKey: Keys.BottomTextKey)
        archiver.encodeObject(image, forKey: Keys.ImageKey)
        archiver.encodeObject(memeImage, forKey: Keys.MemeImageKey)
    }
    
    required init(coder unarchiver: NSCoder) {
        
        
        // Unarchive the data, one property at a time
        //        name = unarchiver.decodeObjectForKey(Keys.Name) as! String
        //        id = unarchiver.decodeObjectForKey(Keys.ID) as! Int
        //        imagePath = unarchiver.decodeObjectForKey(Keys.ProfilePath) as! String
        //        movies = unarchiver.decodeObjectForKey(Keys.Movies) as! [Movie]
        
        topText = unarchiver.decodeObjectForKey(Keys.TopTextKey) as! String
        bottomText = unarchiver.decodeObjectForKey(Keys.BottomTextKey) as! String
        image = unarchiver.decodeObjectForKey(Keys.ImageKey) as! UIImage
        memeImage = unarchiver.decodeObjectForKey(Keys.MemeImageKey) as! UIImage
        
        super.init()
        
    }
}