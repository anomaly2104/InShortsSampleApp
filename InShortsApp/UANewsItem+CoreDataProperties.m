//
//  UANewsItem+CoreDataProperties.m
//  InShortsApp
//
//  Created by Udit Agarwal on 19/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UANewsItem+CoreDataProperties.h"

@implementation UANewsItem (CoreDataProperties)

+ (NSFetchRequest<UANewsItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UANewsItem"];
}

@dynamic authorName;
@dynamic content;
@dynamic createdAt;
@dynamic hashID;
@dynamic imageURLString;
@dynamic isBookmarked;
@dynamic sourceName;
@dynamic sourceURLString;
@dynamic title;

@end
