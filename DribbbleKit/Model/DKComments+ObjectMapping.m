//
//  DKComments+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKComments+ObjectMapping.h"

#import "DKComment+ObjectMapping.h"

@implementation DKComments (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
    NSDictionary *commentObjectMappingDictionary = @{
                                                     @"page": @"page",
                                                     @"pages": @"pages",
                                                     @"per_page": @"pageSize",
                                                     @"total": @"total"
                                                     };
    
    return commentObjectMappingDictionary;
}

+ (RKObjectMapping *)objectRequestMapping {
    RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
    [objectMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [objectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"comments"
                                                                                  toKeyPath:@"comments"
                                                                                withMapping:[DKComment objectRequestMapping]]];
    
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
    RKEntityMapping *commentMapping = (RKEntityMapping *)[DKComment objectResponseMappingWithManagedObjectStore:managedObjectStore];
    
    RKEntityMapping *entityResponseMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
                                                                 inManagedObjectStore:managedObjectStore];
    [entityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [entityResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"comments"
                                                                                          toKeyPath:@"comments"
                                                                                        withMapping:commentMapping]];
    
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
