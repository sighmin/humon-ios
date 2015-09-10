//
//  HUMUserSession.m
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/10.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import "HUMUserSession.h"
#import <SSKeychain/SSKeychain.h>

static NSString *const HUMService = @"Humon";
static NSString *const HUMUserID = @"currentUserID";
static NSString *const HUMUserToken = @"currentUserToken";

@implementation HUMUserSession

+ (NSString *)userID
{
    NSString *userID = [SSKeychain passwordForService:HUMService account:HUMUserID];
    
    return userID;
}

+ (NSString *)userToken
{
    NSString *userToken = [SSKeychain passwordForService:HUMService account:HUMUserToken];
    
    return userToken;
}

+ (void)setUserID:(NSString *)userID
{
    if (!userID) {
        [SSKeychain deletePasswordForService:HUMService account:HUMUserID];
        return;
    }
    
    NSString *IDString = [NSString stringWithFormat:@"%@", userID];
    [SSKeychain setPassword:IDString forService:HUMService account:HUMUserID error:nil];
}

+ (void)setUserToken:(NSString *)userToken
{
    if (!userToken) {
        [SSKeychain deletePasswordForService:HUMService account:HUMUserToken];
        return;
    }
    
    [SSKeychain setPassword:userToken forService:HUMService account:HUMUserToken error:nil];
}

+ (BOOL)userIsLoggedIn
{
    BOOL hasUserID = [self userID] ? YES : NO;
    BOOL hasUserToken = [self userToken] ? YES : NO;
    return hasUserID && hasUserToken;
}

@end
