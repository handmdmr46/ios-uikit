//
//  CollectionViewController.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    var memes: [Meme]!
    var memeCount = 0
    let allVillains = Villain.allVillains
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // connection: connect to flow layout control in collection view storyboard
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set Meme", style: UIBarButtonItemStyle.Plain, target: self, action: "getMemeViewController")
        
        // dont need to set the delegate and dataSource!! - NOTE: already connected with collection view
        // this may be different if you add collection view to view controller in storyboard
        
        // set collection view cell layout
        let space: CGFloat = 3.0
        let cellWidth = (self.view.frame.size.width - (2 * space)) / 3
        let cellHeight = (self.view.frame.size.height - (2 * space) ) / 3
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
        // memes array from AppDelegate.swift
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if (appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
            myCollectionView.reloadData()
        }
        
    }
    
    func getMemeViewController() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //MARK: Collection View Data Source
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("CollectionCellController", forIndexPath: indexPath) as! CollectionCellController
        
        let meme = memes[indexPath.row]
        
        cell.imageView.image = meme.memeImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        vc.meme = self.memes[indexPath.row]
        
        // this way has no back button for top nav bar
        //self.presentViewController(vc, animated: true, completion: nil)
        
        // allows back button at top navigation
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

