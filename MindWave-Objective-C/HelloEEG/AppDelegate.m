//
//  AppDelegate.m
//  HelloEEG
//
//  Created by FEI DENG on 11/19/12.
//  Copyright (c) 2012 FEI DENG. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // initialize the thinkgear object
    thinkGear = [[ThinkGearObjC alloc] init];
    [thinkGear setDelegate:self];

    deviceNameToSearch = @"MindWaveMobile";
    
    if([thinkGear connected] == NO) {
        
        NSArray *devContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/dev" error:nil];
        NSPredicate *ttyPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith 'tty.'"];
        NSArray *deviceList = [devContents filteredArrayUsingPredicate:ttyPredicate];
        
        devicePortName = @"";
        BOOL found = NO;
        
        if(deviceNameToSearch.length > 0){
            for(id device in deviceList){
                NSString *temp = (NSString *)device;
                NSLog(@"%@", temp);
                if([temp rangeOfString:deviceNameToSearch].location != NSNotFound){
                    if([deviceNameToSearch isEqualToString:@"MindWave"]){
                        if([temp rangeOfString:@"MindWaveMobile"].location == NSNotFound){
                            found = YES;
                            devicePortName = [@"/dev/" stringByAppendingString:temp];
                            break;
                        }
                    }else {
                        found = YES;
                        devicePortName = [@"/dev/" stringByAppendingString:temp];
                        break;
                    }
                }
            }
        }
        
        if (found) {
            if(devicePortName.length > 0){
                [thinkGear ConnectTo:devicePortName];
            }
        }
        
    }
}

- (void)dataReceived:(NSDictionary *)data {
    /*
    if([data objectForKey:@"poorSignal"]){
        [poorSignal setStringValue:[NSString stringWithFormat:@"%d",[[data valueForKey:@"poorSignal"] intValue]]];
    }
    
    if([data objectForKey:@"rawData"]){
        [raw setStringValue:[NSString stringWithFormat:@"%d",[[data valueForKey:@"rawData"] intValue]]];
        NSLog(@"%@",[NSString stringWithFormat:@"%d",[[data valueForKey:@"rawData"] intValue]]);
    }
    
    if([data objectForKey:@"eSenseMeditation"]){
        [meditation setStringValue:[NSString stringWithFormat:@"%d",[[data valueForKey:@"eSenseMeditation"] intValue]]];
    }
    
    if([data objectForKey:@"eSenseAttention"]){
        [attention setStringValue:[NSString stringWithFormat:@"%d",[[data valueForKey:@"eSenseAttention"] intValue]]];
    }*/
    
}

- (void)accessoryDidConnect:(NSString *)portName {
    NSLog(@"Connected to %@", portName);
}

- (void)accessoryDidDisconnect{
    NSLog(@"Disconnected from device.");
}

- (void)accessoryError: (int) errorCode{
    NSLog(@"Error from device.");
}

@end
