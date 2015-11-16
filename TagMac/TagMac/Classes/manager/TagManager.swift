//
//  TagManager.swift
//  TagMac
//
//  Created by kimimaro on 15/11/16.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//

import Cocoa

class TagManager: NSObject {
    
    // singleton
    class var sharedInstance: TagManager {
        struct Singleton {
            static let sharedInstance = TagManager()
        }
        return Singleton.sharedInstance
    }

    func fetchTagsFromEvernote() {
        
    }
}
