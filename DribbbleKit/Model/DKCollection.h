//
//  DKCollection.h
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKCollection : NSObject

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger total;

- (NSDictionary *)dictionaryValue;

- (DKCollection *)nextPageCollection;
- (BOOL)hasNextPage;

@end
