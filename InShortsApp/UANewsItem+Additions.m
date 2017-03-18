//
//  UANewsItem+Additions.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsItem+Additions.h"
#import <TDTChocolate/TDTCoreDataAdditions.h>

@implementation UANewsItem (Additions)

+ (instancetype)newsItemWithHashID:(NSString *)hashID
            inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  NSParameterAssert(hashID);
  UANewsItem *existing = [self findNewsItemWithHashID:hashID
                               inManagedObjectContext:managedObjectContext];
  if (existing != nil) {
    return existing;
  }
  
  return [self insertNewsItemWithHashID:hashID
                 inManagedObjectContext:managedObjectContext];
}

+ (instancetype)findNewsItemWithHashID:(NSString *)hashID
                inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hashID = %@", hashID];
  return [self tdt_fetchObjectForPredicate:predicate
                    inManagedObjectContext:managedObjectContext];
}

+ (instancetype)insertNewsItemWithHashID:(NSString *)hashID
                  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  UANewsItem *newsItem = [self tdt_insertNewObjectInManagedObjectContext:managedObjectContext];
  newsItem.hashID = hashID;
  newsItem.isBookmarked = NO;
  return newsItem;
}

- (void)toggleBookmarkInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectID *newsItemID = self.objectID;
  
  [managedObjectContext performBlock:^{
    UANewsItem *newsItem = (UANewsItem *)[managedObjectContext tdt_existingObjectWithID:newsItemID];
    newsItem.isBookmarked = !newsItem.isBookmarked;
    [managedObjectContext tdt_save];
  }];
}

@end
