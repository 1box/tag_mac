//
//  TagManager.swift
//  TagMac
//
//  Created by kimimaro on 15/11/16.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//

import Cocoa

let TagManagerDidSaveTagsNotification = "TagManagerDidSaveTagsNotification"

class TagManager: NSObject {
    
    let name_key = "name"
    let id_key = "guid"
    let tag_entity_name = "Tag"
    
    let managedObjectContext = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // singleton
    class var sharedInstance: TagManager {
        struct Singleton {
            static let sharedInstance = TagManager()
        }
        return Singleton.sharedInstance
    }
    
    // override
    deinit {
//        currentTags.removeObserver(self, forKeyPath: "selectionIndexes")
    }
    
//    override func awakeFromNib() {
        // start listening for selection changes in our NSTableView's array controller
//        currentTags.addObserver(self,
//            forKeyPath: "selectionIndexes",
//            options: NSKeyValueObservingOptions.New,
//            context: nil)
//    }
    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "selectionIndexes" {
//            log.debug("Table section changed: keyPath = \(keyPath), \(object?.selectionIndexes)")
//        }
//    }
    
    // manage tags with database
    func saveTagsToDB(tags: NSArray!) {
        for tag in tags {
            
            // TODO: 避免重复数据
//            let fetchRequest = NSFetchRequest(entityName: tag_entity_name)
//            fetchRequest.predicate =
            
            let tagItem = NSEntityDescription.insertNewObjectForEntityForName(tag_entity_name, inManagedObjectContext: managedObjectContext) as! Tag
            
            tagItem.tag_name = tag.name
            tagItem.tag_id = tag.guid
        }
        
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveAction(self)
        
        NSNotificationCenter.defaultCenter().postNotificationName(TagManagerDidSaveTagsNotification, object: nil)
    }
    
    func updateAllTagsFromDB() {
        
        _ = TagManager.sharedInstance.fetchAllTagsFromDB()
        
//        currentTags?.addObjects(tags as [AnyObject])
//        arrayController?.rearrangeObjects()
    }
    
    func fetchAllTagsFromDB() -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: tag_entity_name)
        
//        do {
//            try fileManager.removeItemAtURL(fileURL)
//        } catch {
//            XCTFail("file manager should remove item at URL: \(fileURL)")
//        }
        
        do {
            if let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Tag] {
                
                log.debug("all tags:\(fetchResults)")
                return fetchResults
            }
        } catch {
            log.debug("fetch all tags failed.")
        }
        
        return []
    }
    
    @IBAction func add(sender: AnyObject) {
        log.debug("add new tag.")
    }
}
