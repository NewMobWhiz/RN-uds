//
//  RNIPC.m
//  RNIPC
//
//  Created by Admin on 07/04/17.
//  Copyright © 2017 smmob. All rights reserved.
//

#import "RNIPC.h"
#import "RNIPCManager.h"

@implementation RNIPC

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(startServer:(RCTResponseSenderBlock)callback) {
    BOOL response = [RNIPCManager startServer];
    callback(@[[NSNull null], response]);
}

RCT_EXPORT_METHOD(stopServer:(RCTResponseSenderBlock)callback) {
    BOOL response = [RNIPCManager stopServer];
    
    callback(@[[NSNull null], response]);
}

RCT_EXPORT_METHOD(connectClient:(RCTResponseSenderBlock)callback) {
    BOOL response = [RNIPCManager connectClient];
    
    callback(@[[NSNull null], response]);
}

RCT_EXPORT_METHOD(disconnectClient:(RCTResponseSenderBlock)callback) {
    BOOL response = [RNIPCManager disconnectClient];
    
    callback(@[[NSNull null], response]);
}

RCT_EXPORT_METHOD(messageToServer:(NSDictionary*)message callback:(RCTResponseSenderBlock)callback) {
    [RNIPCManager messageToServer:message];
    BOOL response = [RNIPCManager getMessageFromServer];
    
    callback(@[[NSNull null], response]);
}

@end
