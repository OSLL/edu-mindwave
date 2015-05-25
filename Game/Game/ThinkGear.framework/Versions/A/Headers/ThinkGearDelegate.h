/*
 *  TGAccessoryDelegate.h
 *
 *  Created by Horace Ko on 12/7/09.
 *  Copyright 2009 NeuroSky, Inc.. All rights reserved.
 *
 *  Classes that act as the delegate for the TGAccessoryManager need to implement
 *  this protocol. The TGAccessoryManager fires off the messages in this protocol 
 *  when the appropriate events are seen.
 *
 *  The only required method in this protocol is dataReceived:.
 */

#import <Foundation/Foundation.h>

@protocol ThinkGearDelegate

- (void)dataReceived:(NSDictionary *)data;
- (void)accessoryDidConnect:(NSString *)portName;
- (void)accessoryError: (int) errorCode;
- (void)accessoryDidDisconnect;

@end