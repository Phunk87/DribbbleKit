//
//  DKAPIEngine.m
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKAPIEngine.h"

#import <RestKit/RestKit.h>

// Model
#import "DKPlayer.h"
#import "DKPlayers.h"
#import "DKComment.h"
#import "DKComments.h"
#import "DKShot.h"
#import "DKShots.h"

@interface DKAPIEngine ()
@property (nonatomic, retain) RKObjectManager  *objectManager;
@end

@interface DKAPIEngine (Private)
- (void)_buildMapping;
@end

@implementation DKAPIEngine

+ (DKAPIEngine *)sharedEngine {
    static dispatch_once_t onceToken;
    static DKAPIEngine *SharedEngine;
    dispatch_once(&onceToken, ^{
        SharedEngine = [[self alloc] init];
    });
    
    return SharedEngine;
}

- (id)init {
    self = [super init];
    if (self) {
        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
        NSError *error = nil;
        BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
        if (! success) {
            RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
        }
        NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Store.sqlite"];
        NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
        if (! persistentStore) {
            RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
        }
        [managedObjectStore createManagedObjectContexts];
        
        self.objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://api.dribbble.com"]];
        self.objectManager.managedObjectStore = managedObjectStore;
        
        [self _buildMapping];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Public
- (void)playerProfileDetailsWithPlayerID:(NSString *)playerID {
    DKPlayer *player = [[DKPlayer alloc] init];
    [self.objectManager getObject:player
                             path:[NSString stringWithFormat:@"/players/%@", playerID]
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                              NSLog(@"Result:%@", mappingResult);
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"%@", error);
                          }];
}

#pragma mark - Private
- (void)_buildMapping {
    // DKPlayer
    NSDictionary *playerMappingDictionary = @{
                                              @"id": @"playerID",
                                              @"name": @"name",
                                              @"username": @"userName",
                                              @"url": @"url",
                                              @"avatar_url": @"avatarURL",
                                              @"location": @"location",
                                              @"twitter_screen_name": @"twitterScreenName",
                                              @"drafted_by_player_id": @"draftedByPlayerID",
                                              @"shots_count": @"shotsCount",
                                              @"draftees_count": @"drafteesCount",
                                              @"followers_count": @"followersCount",
                                              @"following_count": @"followingCount",
                                              @"comments_count": @"commentsCount",
                                              @"comments_received_count": @"commentsReceivedCount",
                                              @"likes_count": @"likesCount",
                                              @"likes_received_count": @"likesReceivedCount",
                                              @"rebounds_count": @"reboundsCount",
                                              @"rebounds_received_count": @"reboundsReceivedCount",
                                              @"created_at": @"creationDate" };
    
    RKObjectMapping *playerObjectRequestMapping = [RKObjectMapping requestMapping];
    [playerObjectRequestMapping addAttributeMappingsFromDictionary:playerMappingDictionary];
    RKRequestDescriptor *playerObjectRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:playerObjectRequestMapping
                                                                                         objectClass:[DKPlayer class]
                                                                                         rootKeyPath:@"player"];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKObjectMapping *playerObjectResponseMapping = [RKObjectMapping mappingForClass:[DKPlayer class]];
    [playerObjectResponseMapping addAttributeMappingsFromDictionary:playerMappingDictionary];
    RKResponseDescriptor *playerObjectResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:playerObjectResponseMapping
                                                                                     pathPattern:nil
                                                                                         keyPath:@"player"
                                                                                     statusCodes:statusCodes];
    [self.objectManager addRequestDescriptor:playerObjectRequestDescriptor];
    [self.objectManager addResponseDescriptor:playerObjectResponseDescriptor];
}

@end
