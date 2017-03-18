//
//  UANewsItem+JSONDecoding.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsItem+CoreDataClass.h"

@interface UANewsItem (JSONDecoding)

+ (UANewsItem *)newsItemFromJSON:(NSDictionary *)JSON
          inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                           error:(NSError **)error;

@end
