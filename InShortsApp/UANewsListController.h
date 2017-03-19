//
//  UAViewController.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UANewsListControllerDelegate;

@class UANewsItem;

@interface UANewsListController : UIViewController

@property (nonatomic, weak) id<UANewsListControllerDelegate> delegate;

@property (nonatomic) NSPredicate *predicate;

@end

@protocol UANewsListControllerDelegate <NSObject>

- (void)newsListControllerDidLoad:(UANewsListController *)newsListController;
- (void)newsListControllerDidScrollToBottom:(UANewsListController *)newsListController
                               lastNewsItem:(UANewsItem *)lastNewsItem;
- (void)newsListControllerDidPullToRefresh:(UANewsListController *)newsListController;

@end
