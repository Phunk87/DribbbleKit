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
#import "DKModel.h"

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
        
        [managedObjectStore createPersistentStoreCoordinator];
        
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
        
        managedObjectStore.managedObjectCache = [[[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext] autorelease];
        
        self.objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://api.dribbble.com"]];
        self.objectManager.managedObjectStore = managedObjectStore;
        
        // build mapping
        [self _buildMapping];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Players

- (void)playerWithPlayerID:(NSString *)playerID success:(void (^)(DKPlayer *))successHandler failure:(void (^)(NSError *))failureHandler {
    [self.objectManager getObject:nil
                             path:[NSString stringWithFormat:@"/players/%@", playerID]
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                              NSLog(@"!!! %@", result);
                              if (successHandler) {
                                  successHandler([[result array] lastObject]);
                              }
                          }

                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"!!! %@", error);
                              if (failureHandler) {
                                  failureHandler(error);
                              }
                          }];
}

- (void)followersWithPlayer:(DKPlayer *)player collectionInfo:(DKCollection *)collection success:(void (^)(DKPlayers *))successHandler failure:(void (^)(NSError *))failureHandler {
    [self.objectManager getObject:player
                             path:RKPathFromPatternWithObject(@"/players/:playerID/followers", player)
                       parameters:(collection) ? [collection dictionaryValue] : nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                              NSLog(@"!!! %@", result);
                              if (successHandler) {
                                  successHandler([[result array] lastObject]);
                              }
                          }
     
                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"!!! %@", error);
                              if (failureHandler) {
                                  failureHandler(error);
                              }
                          }];
}

- (void)followingsWithPlayer:(DKPlayer *)player collectionInfo:(DKCollection *)collection success:(void (^)(DKPlayers *))successHandler failure:(void (^)(NSError *))failureHandler {
    [self.objectManager getObject:player
                             path:RKPathFromPatternWithObject(@"/players/:playerID/following", player)
                       parameters:(collection) ? [collection dictionaryValue] : nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                              NSLog(@"!!! %@", result);
                              if (successHandler) {
                                  successHandler([[result array] lastObject]);
                              }
                          }
     
                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"!!! %@", error);
                              if (failureHandler) {
                                  failureHandler(error);
                              }
                          }];
}

#pragma mark - Shots

- (void)shotWithShotID:(NSString *)shotID success:(void (^)(DKShot *))successHandler failure:(void (^)(NSError *))failureHandler {
    [self.objectManager getObject:nil
                             path:[NSString stringWithFormat:@"/shots/%@", shotID]
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                              NSLog(@"!!! %@", result);
                              if (successHandler) {
                                  successHandler([[result array] lastObject]);
                              }
                          }
     
                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"!!! %@", error);
                              if (failureHandler) {
                                  failureHandler(error);
                              }
                          }];
}

- (void)shotsInResponseToShotWithShotID:(NSString *)shotID success:(void (^)(DKShots *))successHandler failure:(void (^)(NSError *))failureHandler {
    
}

- (void)shotsWithType:(DKShotsType)type collectionInfo:(DKCollection *)collection success:(void (^)(DKShots *))successHandler failure:(void (^)(NSError *))failureHandler {

}

#pragma mark - Private

- (void)_buildMapping {
    RKObjectManager *objectManager = self.objectManager;
    RKManagedObjectStore *managedObjectStore= objectManager.managedObjectStore;
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    // Player
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
    RKObjectMapping *playerRequestMapping = [RKObjectMapping requestMapping];
    [playerRequestMapping addAttributeMappingsFromDictionary:playerMappingDictionary];
    RKRequestDescriptor *playerRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:playerRequestMapping objectClass:[DKPlayer class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:playerRequestDescriptor];
    
    RKEntityMapping *playerResponseMapping = [RKEntityMapping mappingForEntityForName:@"DKPlayer" inManagedObjectStore:managedObjectStore];
    playerResponseMapping.identificationAttributes = @[@"playerID"];
    [playerResponseMapping addAttributeMappingsFromDictionary:playerMappingDictionary];
    
    RKResponseDescriptor *playerResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:playerResponseMapping
                                                                                              pathPattern:@"/players/:playerID"
                                                                                                  keyPath:nil
                                                                                              statusCodes:statusCodes];
    [objectManager addResponseDescriptor:playerResponseDescriptor];
    
    // Shot
    NSDictionary *shotObjectMappingDictionary = @{
                                                  @"id": @"shotID",
                                                  @"title": @"title",
                                                  @"url": @"url",
                                                  @"short_url": @"shortURL",
                                                  @"image_url": @"imageURL",
                                                  @"image_teaser_url": @"imageTeaserURL",
                                                  @"width": @"width",
                                                  @"height": @"height",
                                                  @"views_count": @"viewsCount",
                                                  @"likes_count": @"likesCount",
                                                  @"comment_count": @"commentsCount",
                                                  @"rebounds_count": @"reboundsCount",
                                                  @"rebound_source_id": @"reboundSourceID",
                                                  @"created_at": @"creationDate"
                                                  };
    RKObjectMapping *shotRequestMapping = [RKObjectMapping requestMapping];
    [shotRequestMapping addAttributeMappingsFromDictionary:shotObjectMappingDictionary];
    [shotRequestMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player" toKeyPath:@"player" withMapping:playerRequestMapping]];
    RKRequestDescriptor *shotRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:shotRequestMapping objectClass:[DKShot class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:shotRequestDescriptor];
    
    RKEntityMapping *shotResonseMapping = [RKEntityMapping mappingForEntityForName:@"DKShot" inManagedObjectStore:managedObjectStore];
    shotResonseMapping.identificationAttributes = @[@"shotID"];
    [shotResonseMapping addAttributeMappingsFromDictionary:shotObjectMappingDictionary];
    [shotResonseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player" toKeyPath:@"player" withMapping:playerResponseMapping]];
    RKResponseDescriptor *shotResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:shotResonseMapping
                                                                                           pathPattern:@"/shots/:shotID"
                                                                                               keyPath:nil
                                                                                           statusCodes:statusCodes];
    [objectManager addResponseDescriptor:shotResponseDescriptor];
    
    // Comment
    NSDictionary *commentObjectMappingDictionary = @{
                                                     @"id": @"commentID",
                                                     @"body": @"body",
                                                     @"likes_count": @"likesCount",
                                                     @"created_at": @"creationDate"
                                                     };
    RKObjectMapping *commentRequestMapping = [RKObjectMapping requestMapping];
    [commentRequestMapping addAttributeMappingsFromDictionary:commentObjectMappingDictionary];
    [commentRequestMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player" toKeyPath:@"player" withMapping:playerRequestMapping]];
    RKRequestDescriptor *commentRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:commentRequestMapping objectClass:[DKComment class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:commentRequestDescriptor];
    
    RKEntityMapping *commentResponseMapping = [RKEntityMapping mappingForEntityForName:@"DKComment" inManagedObjectStore:managedObjectStore];
    commentResponseMapping.identificationAttributes = @[@"commentID"];
    [commentResponseMapping addAttributeMappingsFromDictionary:commentObjectMappingDictionary];
    [commentResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player" toKeyPath:@"player" withMapping:playerResponseMapping]];
    RKResponseDescriptor *commentResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:commentResponseMapping
                                                                                              pathPattern:nil
                                                                                                  keyPath:@"comments"
                                                                                              statusCodes:statusCodes];
    [objectManager addResponseDescriptor:commentResponseDescriptor];
    
    // Collection
    NSDictionary *collectionObjectMappingDictionary = @{
                                                        @"page": @"page",
                                                        @"pages": @"pageCount",
                                                        @"per_page": @"pageSize",
                                                        @"total": @"total"
                                                        };
    
    // Players
    RKObjectMapping *playersRequestMapping = [RKObjectMapping requestMapping];
    [playersRequestMapping addAttributeMappingsFromDictionary:collectionObjectMappingDictionary];
    [playersRequestMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"players" toKeyPath:@"players" withMapping:playerRequestMapping]];
    RKRequestDescriptor *playersRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:playersRequestMapping objectClass:[DKPlayers class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:playersRequestDescriptor];
    
    RKObjectMapping *playersResponseMapping = [RKObjectMapping mappingForClass:[DKPlayers class]];
    [playersResponseMapping addAttributeMappingsFromDictionary:collectionObjectMappingDictionary];
    [playersResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"players" toKeyPath:@"players" withMapping:playerResponseMapping]];
    RKResponseDescriptor *playersResponseDescriptor1 = [RKResponseDescriptor responseDescriptorWithMapping:playersResponseMapping
                                                                                              pathPattern:@"/players/:playerID/followers"
                                                                                                  keyPath:nil
                                                                                              statusCodes:statusCodes];
    RKResponseDescriptor *playersResponseDescriptor2 = [RKResponseDescriptor responseDescriptorWithMapping:playersResponseMapping
                                                                                               pathPattern:@"/players/:playerID/following"
                                                                                                   keyPath:nil
                                                                                               statusCodes:statusCodes];
    RKResponseDescriptor *playersResponseDescriptor3 = [RKResponseDescriptor responseDescriptorWithMapping:playersResponseMapping
                                                                                               pathPattern:@"/players/:playerID/draftees"
                                                                                                   keyPath:nil
                                                                                               statusCodes:statusCodes];
    [objectManager addResponseDescriptor:playersResponseDescriptor1];
    [objectManager addResponseDescriptor:playersResponseDescriptor2];
    [objectManager addResponseDescriptor:playersResponseDescriptor3];
    
    // Shots
    // Comments
}

@end
