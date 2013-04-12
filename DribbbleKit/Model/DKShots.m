//
//  DKShots.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKShots.h"

@implementation DKShots

- (void)dealloc {
    [_shots release];
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"DKShots: %@", self.shots];
}

@end
