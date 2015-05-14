//
//  AppDelegate.swift
//  smb2
//
//  Created by Yuriy Rebryk on 23/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var thinkGear: ThinkGear?

    func foo() {
        NSLog("LOG");
        foo();
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        thinkGear = ThinkGear()
        thinkGear?.Connect()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}