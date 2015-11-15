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
    @IBOutlet weak var tagListView: NSTableColumn!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int
    {
        //let numberOfRows:Int = 20
        let numberOfRows:Int = getDataArray().count
        return numberOfRows
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject?
    {
        //        var string:String = "row " + String(row) + ", Col" + String(tableColumn.identifier)
        //        return string
        let newString = getDataArray().objectAtIndex(row).objectForKey(tableColumn!.identifier)
        return newString;
    }
    
    func getDataArray () -> NSArray{
        let dataArray:[NSDictionary] = [["FirstName": "Debasis", "LastName": "Das"],
            ["FirstName": "Nishant", "LastName": "Singh"],
            ["FirstName": "John", "LastName": "Doe"],
            ["FirstName": "Jane", "LastName": "Doe"],
            ["FirstName": "Mary", "LastName": "Jane"]];
        print(dataArray);
        return dataArray;
    }
}
