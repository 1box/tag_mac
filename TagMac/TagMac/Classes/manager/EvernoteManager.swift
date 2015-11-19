//
//  EvernoteManager.swift
//  TagMac
//
//  Created by kimimaro on 15/11/16.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//

import Cocoa
import EvernoteSDKMac

//public typealias EvernoteAuthCompletionHandler = (NSError?) -> Void

class EvernoteManager: NSObject {
    
    class var sharedInstance: EvernoteManager {
        struct Singleton {
            static let sharedInstance = EvernoteManager()
        }
        return Singleton.sharedInstance
    }

    /**
     validation consumer key&secret to Evernote Dev
     */
    func validationEvernoteDev() {
        
        // Fill in the consumer key and secret with the values that you received from Evernote
        // To get an API key, visit http://dev.evernote.com/documentation/cloud/
        let evernoteHost = BootstrapServerBaseURLStringSandbox // BootstrapServerBaseURLStringCN
        let consumerKey = "kimirius"
        let consumerSecret = "8681c0a901f72b82"
        
        EvernoteSession.setSharedSessionHost(evernoteHost, consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    /**
     check authentication and request to auth if not
     
     - parameter handler: auth completion handler
     */
    func checkAuthToEvernote(handler: EvernoteAuthCompletionHandler!) {
        if EvernoteSession.sharedSession().isAuthenticated == false {
            self.authToEvernote(handler)
        } else {
            self.fetchTagsFromEvernote()
            handler(nil)
        }
    }
    
    /**
     show authenticate with completion handler
     */
    func authToEvernote(handler: EvernoteAuthCompletionHandler!) {
        
//        let keyWindow = NSApplication.sharedApplication().keyWindow
//        let mainWindow = NSApplication.sharedApplication().mainWindow
//        let windows = NSApplication.sharedApplication().windows
        
        EvernoteSession.sharedSession().authenticateWithWindow(
            NSApplication.sharedApplication().windows[0],
            completionHandler: { (error: NSError!) in
                
                if (error != nil || EvernoteSession.sharedSession().isAuthenticated == false) {
                    // authentication failed :(
                    log.debug("authentication failed with error:\(error)")
                } else {
                    // authentication succeeded :)
                    self.fetchTagsFromEvernote()
                }
                
                handler(error)
        })
    }
    
    func fetchTagsFromEvernote() {
        let noteStore = EvernoteNoteStore.init(session: EvernoteSession.sharedSession()!)
//        noteStore.setIsBusiness(false)
//        noteStore.setLinkedNotebook(nil)
        noteStore.listTagsWithSuccess(
            { (tags: [AnyObject]!) in
                log.debug("tags:\(tags) in noteStore:\(noteStore)")
                
                TagManager.sharedInstance.saveTagsToDB(tags as NSArray!)
            },
            failure: { (error: NSError!) in
                log.debug("list tags failed with error:\(error)")
        })
    }
}
