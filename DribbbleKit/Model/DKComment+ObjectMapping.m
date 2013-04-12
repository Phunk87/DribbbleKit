//
//  DKComment+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKComment+ObjectMapping.h"

#import "DKPlayer+ObjectMapping.h"

static RKRequestDescriptor *RequestDescriptor = nil;
static RKResponseDescriptor *ResponseDescriptor = nil;
static RKEntityMapping *EntityResponseMapping = nil;

@implementation DKComment (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
    NSDictionary *commentObjectMappingDictionary = @{
                                                     @"id": @"commentID",
                                                     @"body": @"body",
                                                     @"likes_count": @"likesCount",
                                                     @"created_at": @"creationDate"
                                                     };
    
    return commentObjectMappingDictionary;
}

+ (RKObjectMapping *)objectRequestMapping {
    RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
    [objectMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [objectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player"
                                                                                  toKeyPath:@"player"
                                                                                withMapping:[DKPlayer objectRequestMapping]]];
    
    return objectMapping;
}

+ (RKRequestDescriptor *)objectRequestDesctiptor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKObjectMapping *objectMapping = [self objectRequestMapping];
        RequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:objectMapping
                                                                  objectClass:[self class]
                                                                  rootKeyPath:nil];
    });
    
    return RequestDescriptor;
}

+ (RKObjectMapping *)objectResponseMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        EntityResponseMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
                                                                     inManagedObjectStore:managedObjectStore];
        EntityResponseMapping.identificationAttributes = @[@"commentID"];
        [EntityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
        [EntityResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player"
                                                                                              toKeyPath:@"player"
                                                                                            withMapping:EntityResponseMapping]];
    });
    
    return EntityResponseMapping;
}

+ (RKResponseDescriptor *)objectResponseDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKEntityMapping *objectMapping = (RKEntityMapping *)[self objectResponseMappingWithManagedObjectStore:managedObjectStore];
        ResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                                     pathPattern:nil
                                                                         keyPath:nil
                                                                     statusCodes:statusCodes];
    });
    
    return ResponseDescriptor;
}

@end
