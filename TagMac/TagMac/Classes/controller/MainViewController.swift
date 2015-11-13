//
//  ViewController.swift
//  TagMac
//
//  Created by kimimaro on 15/11/13.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//

import Cocoa

class MainViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        #if DEBUG
            self.view.shouldDrawColor()
        #endif
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

