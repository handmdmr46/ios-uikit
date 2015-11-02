//
//  TableViewController.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    var memeCount = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set Meme", style: UIBarButtonItemStyle.Plain, target: self, action: "getMemeViewController")
        
        // dont forget to set the delegate and dataSource!!
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // memes array from AppDelegate.swift
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        // have to reload table after array has been set
        if (appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
            tableView.reloadData()
        }
    }
    
    func getMemeViewController() {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: get cell, set image and text for cell, return cell
        
        // example code
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell")!
        let meme = self.memes[indexPath.row]
        
        cell.textLabel?.text = "Top: \(meme.topText)"
        cell.detailTextLabel?.text = "Bottom: \(meme.bottomText)"
        cell.imageView?.image = meme.image
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //TODO: get cell storyboard and segue to detailViewController, make DetailViewController
        
        // example code
        /*
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        */
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        vc.meme = self.memes[indexPath.row]
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    //
    //    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
}

