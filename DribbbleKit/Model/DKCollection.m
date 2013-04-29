//
//  DKCollection.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKCollection.h"

@implementation DKCollection

- (NSDictionary *)dictionaryValue {
    return @{
             @"page": @(_page),
             @"pages": @(_pageCount),
             @"per_page": @(_pageSize),
             @"total": @(_total)
             };
}

- (DKCollection *)nextPageCollection {
    DKCollection *nextPageCollection = nil;
    if ([self hasNextPage]) {
        nextPageCollection = [[[DKCollection alloc] init] autorelease];
        nextPageCollection.page = _page + 1;
        nextPageCollection.pageCount = _pageCount;
        nextPageCollection.pageSize = _pageSize;
        nextPageCollection.total = _total;
    }
    
    return nextPageCollection;
}

- (BOOL)hasNextPage {
    if (self.page < self.pageCount)
        return YES;
    return NO;
}

@end
