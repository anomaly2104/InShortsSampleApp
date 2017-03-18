//
//  UANewsItem+CoreDataProperties.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UANewsItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UANewsItem (CoreDataProperties)

+ (NSFetchRequest<UANewsItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *hashID;
@property (nullable, nonatomic, copy) NSString *authorName;
@property (nullable, nonatomic, copy) NSString *sourceURLString;
@property (nonatomic) BOOL isBookmarked;
@property (nullable, nonatomic, copy) NSString *sourceName;
@property (nullable, nonatomic, copy) NSDate *createdAt;
@property (nullable, nonatomic, copy) NSString *imageURLString;

@end

NS_ASSUME_NONNULL_END
