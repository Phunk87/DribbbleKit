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

@end
