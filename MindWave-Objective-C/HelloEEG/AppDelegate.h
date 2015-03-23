//
//  AppDelegate.h
//  HelloEEG
//
//  Created by FEI DENG on 11/19/12.
//  Copyright (c) 2012 FEI DENG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ThinkGear/ThinkGear.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, ThinkGearDelegate>
{
    IBOutlet NSTextField *poorSignal;
    IBOutlet NSTextField *raw;
    IBOutlet NSTextField *attention;
    IBOutlet NSTextField *meditation;
 
    ThinkGearObjC *thinkGear;
    
    NSString *devicePortName;
    NSString *deviceNameToSearch;
}

@property (assign) IBOutlet NSWindow *window;

- (void)dataReceived:(NSDictionary *)data;

@end
