//
//  DKObjectMappingProtocol.h
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

@protocol DKObjectMappingProtocol <NSObject>
@required
+ (NSDictionary *)objectMappingDictionary;

+ (RKObjectMapping *)objectRequestMapping;
+ (RKRequestDescriptor *)objectRequestDesctiptor;

+ (RKObjectMapping *)objectResponseMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;
+ (RKResponseDescriptor *)objectResponseDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;

@end
