//
//  ThinkGearObjC.h
//  MindView
//
//  Created by Masamine Someha on 2/27/12.
//  Copyright (c) 2012 NeuroSky Inc. All rights reserved.
//

#import "ThinkGearDelegate.h"
//#import "TGHrv.h"

#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "ORSSerialPortManager.h"

typedef enum {
    TGRawData = 0x01,
    TGAnalyzedData = 0x02
} RecordFlag;

@interface ThinkGearObjC : NSObject <NSStreamDelegate>{
    BOOL connected;
    BOOL rawEnabled;
    BOOL isRecording;
    BOOL readyToSend;
    
    __unsafe_unretained id<ThinkGearDelegate> delegate;
    NSTimeInterval dispatchInterval;
    NSMutableString * dataString;
    NSMutableString * blinkString;
    NSMutableString * rawString;
    
    NSMutableDictionary * data;
    
    NSThread * notificationThread;
    Byte *tempbuffer;
    NSInputStream * inputStream;
    NSOutputStream * outputStream;
    
    int rawWaveData;
    
    uint8_t * payloadBuffer;
    int payloadBytesRemaining;
    
    int rawPackets;
    NSMutableArray *rawBuffer;
    
    NSString *portName;
    
    uint8_t recordFlag;
    NSString * logFilePath;
    NSString * logRow;
    NSFileHandle * logFileHandle;
    
    int meditationValue;
    int attentionValue;
    int poorsignalValue;
    int poorSignalCount;
    
    NSMutableArray * serialPortArray;
}

#pragma mark Properties
@property (nonatomic, readonly) int meditationValue;
@property (nonatomic, readonly) int attentionValue;
@property (nonatomic, readonly) int poorsignalValue;
@property (nonatomic, readonly) int poorSignalCount;

@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, readonly) BOOL isRecording;
@property (nonatomic, readonly) BOOL readyToSend;
@property (nonatomic, assign) id<ThinkGearDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval dispatchInterval;
@property BOOL rawEnabled;

- (int)getVersion;
- (void)ConnectTo:(NSString *)portNameString;
- (void)Disconnect;
- (void)startRecording:(NSString *)applicationSupportFolder withFlag:(uint8_t)flag;
- (void)stopRecording:(NSString *)savePath;
- (void)sendBytes:(uint8_t *)bytes length:(int)length;

//- (NSArray *)getSerialPortArray;
- (void)Connect;

@end
