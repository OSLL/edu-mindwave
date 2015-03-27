//
//  ThinkGear.swift
//  smb2
//
//  Created by Yuriy Rebryk on 23/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation

class ThinkGear: ThinkGearDelegate {
    private var thinkGear: ThinkGearObjC
    private var devicePortName: NSString?
    private var deviceNameToSearch: NSString? = "MindWaveMobile"
    
    init() {
        thinkGear = ThinkGearObjC()
        thinkGear.delegate = self
    }
    
    var blinkStrength = 0
    var eSenseMeditation = 0
    var eSenseAttention = 0
    var poorSignal = 0
    var eegTheta = 0
    var eegDelta = 0
    var eegLowBeta = 0
    var eegHighBeta = 0
    var eegLowGamma = 0
    var eegHighGamma = 0
    var eegLowAlpha = 0
    var eegHighAlpha = 0
    
    var connected: Bool {
        return thinkGear.connected
    }
    
    func Connect() -> Bool {
        if thinkGear.connected == true {
            NSLog("Device already connected!")
            return true
        }
        
        devicePortName = ""
        var found = false
        
        var devContents: NSArray? = NSFileManager.defaultManager().contentsOfDirectoryAtPath("/dev", error: nil);
        var ttyPredicate: NSPredicate? = NSPredicate(format: "SELF beginswith 'tty.'")
        var deviceList: NSArray? = devContents?.filteredArrayUsingPredicate(ttyPredicate!);
        
        for device in deviceList! {
            var temp = device as! String
            if temp.rangeOfString((deviceNameToSearch as! String)) != nil {
                found = true
                devicePortName = "/dev/" + temp
                break
            }
        }
        
        if found && devicePortName != "" {
            thinkGear.ConnectTo(devicePortName as! String)
            return true
        }
        return false
    }
    
    @objc func dataReceived(data: [NSObject : AnyObject]!) {
        if (data as NSDictionary)["blinkStrength"] != nil {
            blinkStrength = ((data as NSDictionary)["blinkStrength"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eSenseMeditation"] != nil {
            eSenseMeditation = ((data as NSDictionary)["eSenseMeditation"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eSenseAttention"] != nil {
            eSenseAttention = ((data as NSDictionary)["eSenseAttention"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["poorSignal"] != nil {
            poorSignal = ((data as NSDictionary)["poorSignal"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegTheta"] != nil {
            eegTheta = ((data as NSDictionary)["eegTheta"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegDelta"] != nil {
            eegDelta = ((data as NSDictionary)["eegDelta"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegLowBeta"] != nil {
            eegLowBeta = ((data as NSDictionary)["eegLowBeta"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegHighBeta"] != nil {
            eegHighBeta = ((data as NSDictionary)["eegHighBeta"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegLowGamma"] != nil {
            eegLowGamma = ((data as NSDictionary)["eegLowGamma"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegHighGamma"] != nil {
            eegHighGamma = ((data as NSDictionary)["eegHighGamma"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegLowAlpha"] != nil {
            eegLowAlpha = ((data as NSDictionary)["eegLowAlpha"] as! Int?) ?? 0
        }
        if (data as NSDictionary)["eegHighAlpha"] != nil {
            eegHighAlpha = ((data as NSDictionary)["eegHighAlpha"] as! Int?) ?? 0
        }
    }
    
    @objc func accessoryDidConnect(portName: String!) {
        NSLog("Connected to %@", portName as String)
    }
    
    @objc func accessoryDidDisconnect() {
        NSLog("Disconnected from device.")
    }
    
    @objc func accessoryError(errorCode: Int32) {
        NSLog("Error from device.");
    }
}