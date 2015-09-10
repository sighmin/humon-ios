//
//  HUMRailsClient.m
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/10.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import "HUMRailsClient.h"

static NSString *const HUMAppSecret = @"c0754828-9052-4229-b2da-5d83a8f72926";

@interface HUMRailsClient ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation HUMRailsClient

- (instancetype)init
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = 30.0;
    sessionConfiguration.timeoutIntervalForResource = 30.0;
    
    NSDictionary *headers = @{
                              @"Accept" : @"application/json",
                              @"Content-Type" : @"application/json",
                              @"tb-device-token" : [[NSUUID UUID] UUIDString],
                              @"tb-app-secret" : HUMAppSecret
                              };
    [sessionConfiguration setHTTPAdditionalHeaders:headers];
    
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    return self;
}

+ (instancetype)sharedClient
{
    static HUMRailsClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HUMRailsClient alloc] init];
    });
    
    return _sharedClient;
}

@end
