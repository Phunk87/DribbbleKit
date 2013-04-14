//
//  DKAPIEngine.h
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kDKShotsTypeUnknow = 0,
    kDKShotsTypeDebuts,
    kDKShotsTypeEveryone,
    kDKShotsTypePopular
} DKShotsType;

@class DKComment, DKComments, DKPlayer, DKPlayers, DKShot, DKShots, DKCollection;

@interface DKAPIEngine : NSObject

+ (DKAPIEngine *)sharedEngine;

// players
- (void)playerWithPlayerID:(NSString *)playerID success:(void (^)(DKPlayer *))successHandler failure:(void (^)(NSError *))failureHandler;
- (void)followersWithPlayer:(DKPlayer *)player collectionInfo:(DKCollection *)collection success:(void (^)(DKPlayers *))successHandler failure:(void (^)(NSError *))failureHandler;
- (void)followingsWithPlayer:(DKPlayer *)player collectionInfo:(DKCollection *)collection success:(void (^)(DKPlayers *))successHandler failure:(void (^)(NSError *))failureHandler;

// shots
- (void)shotWithShotID:(NSString *)shotID success:(void (^)(DKShot *))successHandler failure:(void (^)(NSError *))failureHandler;
- (void)shotsInResponseToShotWithShotID:(NSString *)shotID success:(void (^)(DKShots *))successHandler failure:(void (^)(NSError *))failureHandler;
- (void)shotsWithType:(DKShotsType)type collectionInfo:(DKCollection *)collection success:(void (^)(DKShots *))successHandler failure:(void (^)(NSError *))failureHandler;

@end
