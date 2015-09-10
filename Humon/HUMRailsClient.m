//
//  HUMRailsClient.m
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/10.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import "HUMRailsClient.h"
#import "HUMUserSession.h"

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
    
    NSDictionary *headers = [HUMUserSession userIsLoggedIn] ?
                            @{
                              @"Accept" : @"application/json",
                              @"Content-Type" : @"application/json",
                              @"tb-device-token" : [HUMUserSession userToken],
                              } :
                            @{
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

- (void)createCurrentUserWithCompletionBlock:(HUMRailsClienErrorCompletionBlock)block
{
    // Create a request to POST /users
    NSString *urlString = [NSString stringWithFormat:@"%@users", ROOT_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    // Create a task to encapsulate your request and a completion block
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *reponse, NSError *error) {
        if (!error) {
            // Set the user session properties using the response
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [HUMUserSession setUserToken:responseDictionary[@"device_token"]];
            [HUMUserSession setUserID:responseDictionary[@"id"]];
            
            
            // Create a new configuration with new token
            NSURLSessionConfiguration *newConfiguration = self.session.configuration;
            [newConfiguration setHTTPAdditionalHeaders:@{
                                                         @"Accept" : @"application/json",
                                                         @"Content-Type" : @"application/json",
                                                         @"tb-device-token" : responseDictionary[@"device_token"]
                                                         }];
            [self.session finishTasksAndInvalidate];
            self.session = [NSURLSession sessionWithConfiguration:newConfiguration];
            
            // Execure the completion block regardless of the error
            dispatch_async(dispatch_get_main_queue(), ^{
                block(error);
            });
        }
    }];
    
    [task resume];
    
}

@end
