//
//  HUMRailsClient.h
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/10.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HUMRailsClienErrorCompletionBlock)(NSError *error);

@interface HUMRailsClient : NSObject

+ (instancetype)sharedClient;
- (void)createCurrentUserWithCompletionBlock:(HUMRailsClienErrorCompletionBlock)block;

@end
