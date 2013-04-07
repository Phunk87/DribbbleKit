//
//  DKShots.h
//  DribbbleKit
//
//  Created by 0day on 13-4-6.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DKShot;

@interface DKShots : NSManagedObject

@property (nonatomic, retain) NSNumber * page;
@property (nonatomic, retain) NSNumber * pages;
@property (nonatomic, retain) NSNumber * pageSize;
@property (nonatomic, retain) NSNumber * total;
@property (nonatomic, retain) NSOrderedSet *shots;
@end

@interface DKShots (CoreDataGeneratedAccessors)

- (void)insertObject:(DKShot *)value inShotsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromShotsAtIndex:(NSUInteger)idx;
- (void)insertShots:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeShotsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInShotsAtIndex:(NSUInteger)idx withObject:(DKShot *)value;
- (void)replaceShotsAtIndexes:(NSIndexSet *)indexes withShots:(NSArray *)values;
- (void)addShotsObject:(DKShot *)value;
- (void)removeShotsObject:(DKShot *)value;
- (void)addShots:(NSOrderedSet *)values;
- (void)removeShots:(NSOrderedSet *)values;
@end
