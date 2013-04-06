//
//  DKAPIEngine.h
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kDKShotsTypeDebuts,
    kDKShotsTypeEveryone,
    kDKShotsTypePopular
} DKShotsType;

@interface DKAPIEngine : NSObject

+ (DKAPIEngine *)sharedEngine;

- (void)playerProfileDetailsWithPlayerID:(NSString *)playerID;

@end
