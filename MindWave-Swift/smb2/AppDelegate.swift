//
//  AppDelegate.swift
//  smb2
//
//  Created by Yuriy Rebryk on 23/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate, ThinkGearDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var thinkGear: ThinkGearObjC?
    var devicePortName: NSString?
    var deviceNameToSearch: NSString?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        thinkGear = ThinkGearObjC()
        thinkGear!.delegate = self
       
        println(self)
        
        devicePortName = ""
        deviceNameToSearch = "MindWaveMobile"
        
        var found = false
        
        var devContents: NSArray? = NSFileManager.defaultManager().contentsOfDirectoryAtPath("/dev", error: nil);
        var ttyPredicate: NSPredicate? = NSPredicate(format: "SELF beginswith 'tty.'")
        var deviceList: NSArray? = devContents?.filteredArrayUsingPredicate(ttyPredicate!);
        
        for device in deviceList! {
            var temp = device as! String
            NSLog("device: %@", temp)
            if temp.rangeOfString((deviceNameToSearch as! String)) != nil {
                NSLog("found in %@", temp)
                found = true
                devicePortName = "/dev/" + temp
                break
            }
        }
        
        if found && devicePortName != "" {
            thinkGear!.ConnectTo(devicePortName as! String)
        }
    }
    
    func dataReceived(data: [NSObject : AnyObject]!) {
        var x = 2;
        /*if let poorSignal = data.objectForKey("poorSignal") as? Int {
            NSLog("poorSignal: @%", poorSignal)
        }
        
        if let eSenseMeditation = data.objectForKey("eSenseMeditation") as? Int {
            NSLog("eSenseMeditation: @%", eSenseMeditation)
        }
        
        if let eSenseAttention = data.objectForKey("eSenseAttention") as? Int {
            NSLog("eSenseAttention: @%", eSenseAttention)
        }*/
    }
    
    func accessoryDidConnect(portName: String!) {
        NSLog("Connected to %@", portName as String)
    }
    
    func accessoryDidDisconnect() {
        NSLog("Disconnected from device.")
    }
    
    func accessoryError(errorCode: Int32) {
        NSLog("Error from device.");
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}