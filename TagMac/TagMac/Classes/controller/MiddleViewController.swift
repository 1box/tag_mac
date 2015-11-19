//
//  MiddleViewController.swift
//  TagMac
//
//  Created by kimimaro on 15/11/13.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//

import Cocoa

class MiddleViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tagSearchField: NSSearchField!
    @IBOutlet weak var contextPopUp: NSPopUpButton!
    @IBOutlet weak var tagListView: NSTableView!
    
    @IBOutlet weak var currentTags: NSArrayController!
    
    // override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        [self .updateTags()]
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reportTagManagerDidSaveTagsNotification:", name: TagManagerDidSaveTagsNotification, object: nil)
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // private
    func updateTags() {
        let tagsFromDB = TagManager.sharedInstance.fetchAllTagsFromDB()
        currentTags?.addObjects(tagsFromDB as [AnyObject])
        log.debug("tags from db:\(tagsFromDB)")
    }
    
    // notifications
    func reportTagManagerDidSaveTagsNotification(notification: NSNotification) {
        [self .updateTags()]
        log.debug("receive notification with userinfo:\(notification.userInfo)")
    }
    
    func inspect(selectedObjects: [Tag]) {
        log.debug("double click to inspect.")
    }
    
    // KVO
    deinit {
        currentTags.removeObserver(self, forKeyPath: "selectionIndexes")
    }
    
    override func awakeFromNib() {
        // start listening for selection changes in our NSTableView's array controller
        currentTags.addObserver(self,
            forKeyPath: "selectionIndexes",
            options: NSKeyValueObservingOptions.New,
            context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "selectionIndexes" {
            log.debug("Table section changed: keyPath = \(keyPath), \(object?.selectionIndexes)")
        }
    }
    
    // tableview delegate
//    func numberOfRowsInTableView(aTableView: NSTableView) -> Int
//    {
//        let numberOfRows:Int = currentTags.count
//        return numberOfRows
//    }
//    
//    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject?
//    {
//        let tag = currentTags.objectAtIndex(row) as! Tag
//        
//        var text = ""
//        if tableColumn!.identifier == "name" {
//            text = tag.tag_name as String!
//        } else if tableColumn!.identifier == "guid" {
//            text = tag.tag_id as String!
//        }
//        
//        return text;
//    }
}
