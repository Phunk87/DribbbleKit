//
//  DKPlayer+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKPlayer+ObjectMapping.h"

@implementation DKPlayer (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
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
    
    return playerMappingDictionary;
}

+ (RKObjectMapping *)objectRequestMapping {
    RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
    [objectMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    
    return objectMapping;
}

+ (RKRequestDescriptor *)objectRequestDesctiptor {
    RKObjectMapping *objectMapping = [self objectRequestMapping];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:objectMapping
                                                                                   objectClass:[self class]
                                                                                   rootKeyPath:nil];
    
    return requestDescriptor;
}

+ (RKObjectMapping *)objectResponseMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    RKEntityMapping *entityResponseMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
                                                                 inManagedObjectStore:managedObjectStore];
    entityResponseMapping.identificationAttributes = @[@"playerID"];
    [entityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    
    return entityResponseMapping;
}

+ (RKResponseDescriptor *)objectResponseDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKEntityMapping *objectMapping = (RKEntityMapping *)[self objectResponseMappingWithManagedObjectStore:managedObjectStore];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:statusCodes];
    
    return responseDescriptor;
}

@end
