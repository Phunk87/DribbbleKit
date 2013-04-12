//
//  DKPlayers.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-13.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKPlayers.h"

@implementation DKPlayers

- (void)dealloc {
    [_players release];
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"DKPlayers: %@", self.players];
}

@end
