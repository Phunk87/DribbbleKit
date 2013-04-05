//
//  DKPlayers.h
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
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
@property (nonatomic, retain) NSOrderedSet *palyers;
@end

@interface DKPlayers (CoreDataGeneratedAccessors)

- (void)insertObject:(DKPlayer *)value inPalyersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPalyersAtIndex:(NSUInteger)idx;
- (void)insertPalyers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePalyersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPalyersAtIndex:(NSUInteger)idx withObject:(DKPlayer *)value;
- (void)replacePalyersAtIndexes:(NSIndexSet *)indexes withPalyers:(NSArray *)values;
- (void)addPalyersObject:(DKPlayer *)value;
- (void)removePalyersObject:(DKPlayer *)value;
- (void)addPalyers:(NSOrderedSet *)values;
- (void)removePalyers:(NSOrderedSet *)values;
@end
