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

#pragma mark - Public
- (void)playerProfileDetailsWithPlayerID:(NSString *)playerID success:(void (^)(DKPlayer *))successHandler failure:(void (^)(NSError *))failureHandler {
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DKPlayer" inManagedObjectContext:self.objectManager.managedObjectStore.mainQueueManagedObjectContext];
    DKPlayer *player = [[DKPlayer alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectManager.managedObjectStore.mainQueueManagedObjectContext];
    player.playerID = playerID;
    
    [self.objectManager getObject:nil
                             path:@"/players/misu"
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                              NSLog(@"!!! %@", result);
                          }

                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"!!! %@", error);
                              [self.objectManager.managedObjectStore.mainQueueManagedObjectContext rollback];
                          }];
}

#pragma mark - Private
- (void)_buildMapping {
    NSArray *modelClasses = @[[DKPlayer class]]; //, [DKPlayers class], [DKComment class], [DKComments class], [DKShot class], [DKShots class]];
    RKManagedObjectStore *managedObjectStore = self.objectManager.managedObjectStore;
    
    for (Class<DKObjectMappingProtocol> modelClass in modelClasses) {
        RKRequestDescriptor *requestDescriptor = [modelClass objectRequestDesctiptor];
        RKResponseDescriptor *responseDescriptor = [modelClass objectResponseDescriptorWithManagedObjectStore:managedObjectStore];
        
        [self.objectManager addRequestDescriptor:requestDescriptor];
        [self.objectManager addResponseDescriptor:responseDescriptor];
    }
}

@end
