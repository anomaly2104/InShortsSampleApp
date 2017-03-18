//
//  UANewsItem+Additions.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsItem+CoreDataClass.h"

@interface UANewsItem (Additions)

+ (instancetype)newsItemWithHashID:(NSString *)hashID
            inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (void)toggleBookmarkInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
