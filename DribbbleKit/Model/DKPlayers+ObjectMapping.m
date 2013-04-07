//
//  DKPlayers+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKPlayers+ObjectMapping.h"

#import "DKPlayer+ObjectMapping.h"

@implementation DKPlayers (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
    NSDictionary *playersObjectMappingDictionary = @{
                                                     @"page": @"page",
                                                     @"pages": @"pages",
                                                     @"per_page": @"pageSize",
                                                     @"total": @"total"
                                                     };
    
    return playersObjectMappingDictionary;
}

+ (RKObjectMapping *)objectRequestMapping {
    RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
    [objectMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [objectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"players"
                                                                                  toKeyPath:@"players"
                                                                                withMapping:[DKPlayer objectRequestMapping]]];
    
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
    RKEntityMapping *playerMapping = (RKEntityMapping *)[DKPlayer objectResponseMappingWithManagedObjectStore:managedObjectStore];
    
    RKEntityMapping *entityResponseMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
                                                                 inManagedObjectStore:managedObjectStore];
    [entityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [entityResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"players"
                                                                                          toKeyPath:@"players"
                                                                                        withMapping:playerMapping]];
    
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
