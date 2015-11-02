//
//  MemeViewController.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topMessage: UITextField!
    @IBOutlet weak var bottomMessage: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    /*var memesFilePath : String {
    let manager = NSFileManager.defaultManager()
    let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    return url.URLByAppendingPathComponent("memesArray").path!
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName:UIColor.purpleColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        
        topMessage.defaultTextAttributes = memeTextAttributes
        bottomMessage.defaultTextAttributes = memeTextAttributes
        
        topMessage.textAlignment = NSTextAlignment.Center
        bottomMessage.textAlignment = NSTextAlignment.Center
        
        topMessage.text = "top text"
        bottomMessage.text = "bottom text"
        
        // don't forget to assign delegates
        topMessage.delegate = self
        bottomMessage.delegate = self
        
        // Unarchive the graph when the list is first shown
        /*let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes = NSKeyedUnarchiver.unarchiveObjectWithFile(memesFilePath) as? [Meme] ?? [Meme]()*/
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        // disable camera if not available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Archive the graph any time this list of memes is displayed.
        /*let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        NSKeyedArchiver.archiveRootObject(appDelegate.memes, toFile: memesFilePath)*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (bottomMessage.isFirstResponder()) {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (bottomMessage.isFirstResponder()) {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemeImage() -> UIImage {
        // hide toolbar and navbar
        self.navigationController?.navigationBar.hidden = true
        self.toolBar.hidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // show toolbar and navbar
        self.navigationController?.navigationBar.hidden = false
        self.toolBar.hidden = false
        
        return memeImage
    }
    
    func savedMeme(){
        let memeImage = generateMemeImage()
        let meme = Meme(topText: topMessage.text!, bottomText: bottomMessage.text!, image: imagePickerView.image!, memeImage: memeImage)
        
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        // add meme to the memes array
        appDelegate.memes.append(meme)
        
    }
    
    /**
    *   MARK: Delegate Methods
    */
    
    
    //  Tells the delegate that the user cancelled the pick operation.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //  Tells the delegate that editing began for the specified text field.
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.text == "top text" || textField.text == "bottom text") {
            textField.text = ""
        }
    }
    
    //  Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //  Tells the delegate that the user picked a still image or movie.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            
            //imagePickerView.contentMode = .ScaleAspectFill
            imagePickerView.contentMode = .ScaleAspectFit
            imagePickerView.contentMode = .ScaleToFill
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /**
    *   MARK: Actions
    */
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveAndShare(sender: AnyObject) {
        let memeImage = generateMemeImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = {
            activityType, completed, returnedItems, activityError in
            self.savedMeme()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //        if let navigationController = self.navigationController {
        //            navigationController.popToRootViewControllerAnimated(true)
        //        }
        
    }
    
}


