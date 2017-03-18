//
//  UANewsItem+JSONDecoding.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsItem+JSONDecoding.h"
#import <TDTChocolate/TDTCoreDataAdditions.h>
#import "NSError+UAAdditions.h"
#import "UANewsItem+Additions.h"
#import "NSNumber+UADateAdditions.h"

@implementation UANewsItem (JSONDecoding)

+ (UANewsItem *)newsItemFromJSON:(NSDictionary *)JSON
          inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                           error:(NSError **)error {
  NSString *hashID = JSON[@"hashID"];
  if (hashID == nil) {
    *error = [NSError ua_fieldErrorForJSONElement:JSON
                                            field:@"hashID"];
    return nil;
  }
  
  UANewsItem *newsItem = [UANewsItem newsItemWithHashID:hashID
                                 inManagedObjectContext:managedObjectContext];
  newsItem.content = JSON[@"content"];
  newsItem.title = JSON[@"title"];
  newsItem.authorName = JSON[@"author_name"];
  newsItem.sourceURLString = JSON[@"source_url"];
  newsItem.sourceName = JSON[@"source_name"];
  newsItem.createdAt = [JSON[@"created_at"] ua_dateFromMillisecondsSinceUnixEpoch];
  newsItem.imageURLString = JSON[@"image_url"];
  
  return newsItem;
}

@end
