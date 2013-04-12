//
//  DKShot.h
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DKPlayer;

@interface DKShot : NSManagedObject

@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * imageTeaserURL;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * likesCount;
@property (nonatomic, retain) NSNumber * reboundsCount;
@property (nonatomic, retain) NSNumber * reboundSourceID;
@property (nonatomic, retain) NSString * shortURL;
@property (nonatomic, retain) NSString * shotID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * viewsCount;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) DKPlayer *player;

@end
