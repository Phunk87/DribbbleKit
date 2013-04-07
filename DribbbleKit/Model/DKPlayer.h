//
//  DKPlayer.h
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DKComment, DKPlayers, DKShot;

@interface DKPlayer : NSManagedObject

@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSNumber * commentsReceivedCount;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * draftedByPlayerID;
@property (nonatomic, retain) NSNumber * drafteesCount;
@property (nonatomic, retain) NSNumber * followersCount;
@property (nonatomic, retain) NSNumber * followingCount;
@property (nonatomic, retain) NSNumber * likesCount;
@property (nonatomic, retain) NSNumber * likesReceivedCount;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * playerID;
@property (nonatomic, retain) NSNumber * reboundsCount;
@property (nonatomic, retain) NSNumber * shotsCount;
@property (nonatomic, retain) NSString * twitterScreenName;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) DKPlayers *players;
@property (nonatomic, retain) DKComment *comment;
@property (nonatomic, retain) DKShot *shot;

@end
