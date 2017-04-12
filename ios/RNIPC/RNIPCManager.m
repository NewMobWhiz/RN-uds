//
//  RNIPCManager.m
//  RNIPC
//
//  Created by Admin on 09/04/17.
//  Copyright © 2017 smmob. All rights reserved.
//

#import "RNIPCManager.h"

@implementation GDClient
- (instancetype)init
{
    self = [super init];
    if (self) {
        _serverMessages = [NSMutableArray new];
    }
    return self;
}
- (void)addServerMessage:(NSString *)message {
    [self.serverMessages addObject:message];
}
@end

@implementation RNIPCManager

+ (instancetype)sharedInstance {
    static RNIPCManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RNIPCManager alloc] init];
    });
    return instance;
}

-(BOOL)startServer {
    if (!self.server) {
        
#if TARGET_OS_SIMULATOR
        NSString *socketPath = @"/tmp/test_socket";
#else
        NSString *socketPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test_socket"];
#endif /* TARGET_OS_SIMULATOR */
        self.server = [[GDUnixSocketServer alloc] initWithSocketPath:socketPath];
        self.server.delegate = self;
    }
    
    NSError *error;
    if ([self.server listenWithError:&error]) {
        self.serverIsUp = YES;
        return true;
    } else {
        return false;
    }
}

-(BOOL)stopServer {
    if (self.server) {
        NSError *error;
        if ([self.server closeWithError:&error]) {
            self.serverIsUp = NO;
            return true;
        } else {
            NSLog(@"Server stop failed");
            return false;
        }
    } else {
        NSLog(@"Server object is not initialized!");
        return false;
    }
    return false;
}

-(BOOL)connectClient{
    [self addClientWithName:@""];
    GDUnixSocketClient *connection = self.client.clientConnection;
    
    if (!connection) {
#if TARGET_OS_SIMULATOR
        NSString *socketPath = @"/tmp/test_socket";
#else
        NSString *socketPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test_socket"];
#endif /* TARGET_OS_SIMULATOR */
        connection = [[GDUnixSocketClient alloc] initWithSocketPath:socketPath];
    }
    
    NSError *error;
    if ([connection connectWithAutoRead:YES error:&error]) {
        self.client.connected = YES;
        self.client.clientConnection = connection;
        return true;
    } else {
        NSLog(@"Can't connect");
        return false;
    }
}

-(BOOL)disconnectClient{
    GDUnixSocketClient *connection = self.client.clientConnection;
    if (!connection) {
        NSLog(@"No connection object found!");
        return false;
    }
    
    NSError *error;
    if ([connection closeWithError:&error]) {
        self.client.connected = NO;
        return true;
    } else {
        NSLog(@"Can't close connection");
        return false;
    }
}

-(void)messageToServer:(NSDictionary *)message {
    NSData *data = [NSJSONSerialization dataWithJSONObject:message options:0 error:nil];
    [self.client.clientConnection writeData:data completion:nil];    
}


- (void)addClientWithName:(NSString *)name {
    self.client = [GDClient new];
    self.client.name = name.length ? name : @"John Doe";
}

- (void)processMessage:(NSData *)data fromClientWithID:(NSString *)clientID {
    NSError *JSONError = nil;
    NSDictionary *message = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
    if (JSONError) {
        return;
    }
    
    NSString *name = message[@"name"];
    NSString *cmd = message[@"cmd"];
    if (name) {
        [self sendMessage:[NSString stringWithFormat:@"Hello %@", name] toClientWithID:clientID];
        [self sendMessage:@"Usage: \"cmd\":\"time\"" toClientWithID:clientID];
        return;
    }
    
    if (cmd) {
        if ([cmd isEqualToString:@"time"]) {
            [self sendMessage:[NSString stringWithFormat:@"%@", [NSDate date]] toClientWithID:clientID];
            return;
        }
    }
    
    [self sendMessage:[NSString stringWithFormat:@"Unknown message %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]] toClientWithID:clientID];
}

- (void)sendMessage:(NSString *)message toClientWithID:(NSString *)clientID {
    [self.server sendData:[message dataUsingEncoding:NSUTF8StringEncoding] toClientWithID:clientID completion:^(NSError *error, ssize_t size) {
        if (error) {
            NSLog(@"Failed to send message \"%@\" to client %@", message, clientID);
        } else {
            [self getMessageFromServer:message];
        }
    }];
}

- (NSString*)getMessageFromServer:(NSString*)message {
    return message;
}

#pragma mark - GDUnixSocketServerDelegate Methods

- (void)unixSocketServerDidStartListening:(GDUnixSocketServer *)unixSocketServer {
    NSLog(@"Server started");
}

- (void)unixSocketServerDidClose:(GDUnixSocketServer *)unixSocketServer error:(NSError *)error {
    NSLog(@"Server stopped");
}

- (void)unixSocketServer:(GDUnixSocketServer *)unixSocketServer didAcceptClientWithID:(NSString *)newClientID {
    NSLog(@"Accepted client %@", newClientID);
    [self sendMessage:@"Your name?" toClientWithID:newClientID];
}

- (void)unixSocketServer:(GDUnixSocketServer *)unixSocketServer clientWithIDDidDisconnect:(NSString *)clientID {
    NSLog(@"Client %@ disconnected", clientID);
}

- (void)unixSocketServer:(GDUnixSocketServer *)unixSocketServer didReceiveData:(NSData *)data fromClientWithID:(NSString *)clientID {
    NSString *messageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received message from client %@\n%@", clientID, messageString);
    [self processMessage:data fromClientWithID:clientID];
}

- (void)unixSocketServer:(GDUnixSocketServer *)unixSocketServer didFailToReadForClientID:(NSString *)clientID error:(NSError *)error {
    NSLog(@"Failed to read from client %@", clientID);
}

- (void)unixSocketServerDidFailToAcceptConnection:(GDUnixSocketServer *)unixSocketServer error:(NSError *)error {
    NSLog(@"Failed to accept incoming connection");
}

@end
