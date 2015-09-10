//
//  HUMUserSession.h
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/10.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HUMUser;

@interface HUMUserSession : NSObject

+ (NSString *)userID;
+ (NSString *)userToken;
+ (void)setUserID:(NSString *)userID;
+ (void)setUserToken:(NSString *)userToken;
+ (BOOL)userIsLoggedIn;

@end
