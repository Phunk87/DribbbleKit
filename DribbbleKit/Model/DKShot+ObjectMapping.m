//
//  DKShot+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKShot+ObjectMapping.h"

#import "DKPlayer+ObjectMapping.h"

@implementation DKShot (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
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
    
    return shotObjectMappingDictionary;
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
    entityResponseMapping.identificationAttributes = @[@"shotID"];
    [entityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    [entityResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"player"
                                                                                          toKeyPath:@"player"
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
