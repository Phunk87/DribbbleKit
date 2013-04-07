//
//  DKPlayers.h
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DKPlayer;

@interface DKPlayers : NSManagedObject

@property (nonatomic, retain) NSNumber * page;
@property (nonatomic, retain) NSNumber * pages;
@property (nonatomic, retain) NSNumber * pageSize;
@property (nonatomic, retain) NSNumber * total;
@property (nonatomic, retain) NSOrderedSet *players;
@end

@interface DKPlayers (CoreDataGeneratedAccessors)

- (void)insertObject:(DKPlayer *)value inPlayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayersAtIndex:(NSUInteger)idx;
- (void)insertPlayers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayersAtIndex:(NSUInteger)idx withObject:(DKPlayer *)value;
- (void)replacePlayersAtIndexes:(NSIndexSet *)indexes withPlayers:(NSArray *)values;
- (void)addPlayersObject:(DKPlayer *)value;
- (void)removePlayersObject:(DKPlayer *)value;
- (void)addPlayers:(NSOrderedSet *)values;
- (void)removePlayers:(NSOrderedSet *)values;
@end
