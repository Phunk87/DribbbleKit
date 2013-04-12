//
//  DKComments.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKComments.h"

@implementation DKComments

- (void)dealloc {
    [_comments release];
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"DKComments: %@", self.comments];
}

@end
