//
//  UAViewController.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsListController.h"
#import "UAInshortsView.h"
#import "UANewsCardView.h"
#import <CoreData/CoreData.h>
#import "UAPersistenceStack.h"
#import "UANewsItem+CoreDataClass.h"
#import <TDTChocolate/TDTCoreDataAdditions.h>
#import <TDTChocolate/TDTFoundationAdditions.h>
#import "UANewsCardView.h"
#import "UANewsItem+Additions.h"
#import <SafariServices/SFSafariViewController.h>

@interface UANewsListController () <UAInshortsViewDelegate,
UAInshortsViewDataSource,
NSFetchedResultsControllerDelegate,
UANewsCardViewDelegate>

@property (nonatomic) UAInshortsView *inshortsView;

@property (nonatomic) NSFetchedResultsController *nfrc;

@end

@implementation UANewsListController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.inshortsView = [[UAInshortsView alloc] initWithFrame:self.view.frame];
  self.inshortsView.dataSource = self;
  self.inshortsView.delegate = self;
  [self.view addSubview:self.inshortsView];
  
  [self setupNFRC];
  [self.inshortsView reloadData];
  [self.delegate newsListControllerDidLoad:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  [self showNavigationBarIfNoContentAvailable];
}

- (void)setupNFRC {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[UANewsItem tdt_entityName]];
  fetchRequest.predicate = self.predicate;
  fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                  ascending:NO] ];
  
  self.nfrc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                  managedObjectContext:[UAPersistenceStack sharedInstance].mainMOC
                                                    sectionNameKeyPath:nil
                                                             cacheName:nil];
  self.nfrc.delegate = self;
  [self.nfrc tdt_performFetch];
}

- (UANewsItem *)newsItemAtIndex:(NSUInteger)index {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  return [self.nfrc objectAtIndexPath:indexPath];
}

- (void)showNavigationBarIfNoContentAvailable {
  if ([self numberOfNewsItemsToDisplay] == 0) {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
  }
}

#pragma mark - UAInshortsViewDataSource

- (NSInteger)numberOfNewsItemsToDisplay {
  id <NSFetchedResultsSectionInfo> sectionInfo = [self.nfrc sections].firstObject;
  return (NSInteger)[sectionInfo numberOfObjects];
}

- (NSInteger)numberOfItemsInInshortsView:(UAInshortsView *)inshortsView {
  return [self numberOfNewsItemsToDisplay];
}

- (UIView *)inshortsView:(UAInshortsView *)inshortsView
      viewForItemAtIndex:(NSInteger)index
             reusingView:(UANewsCardView *)view {
  if (index < 0 || index >= [self numberOfNewsItemsToDisplay]) {
    return nil;
  }
  
  if (view == nil) {
    view = [[NSBundle mainBundle] loadNibNamed:@"UANewsCardView"
                                         owner:self
                                       options:nil].firstObject;
    view.frame = CGRectMake(0, 0,inshortsView.frame.size.width, inshortsView.frame.size.height);
    view.delegate = self;
  }
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UANewsItem *newsItem = [self.nfrc objectAtIndexPath:indexPath];
  view.newsItem = newsItem;
  return view;
}

#pragma mark - UAInshortsViewDelegate

- (void)inshortsViewDidPullToRefresh:(UAInshortsView *)inshortsView {
  [self.delegate newsListControllerDidPullToRefresh:self];
}

- (void)inshortsViewCurrentItemIndexDidChange:(UAInshortsView *)inshortsView {
  [self.navigationController setNavigationBarHidden:YES animated:YES];
  if (inshortsView.currentItemIndex >= [self numberOfNewsItemsToDisplay] - 2) {
    UANewsItem *lastNewsItem = [self newsItemAtIndex:[self numberOfNewsItemsToDisplay] - 1];
    [self.delegate newsListControllerDidScrollToBottom:self lastNewsItem:lastNewsItem];
  }
}

- (void)inshortsView:(UAInshortsView *)inshortsView
didSelectItemAtIndex:(NSInteger)index {
  [self.navigationController setNavigationBarHidden:!self.navigationController.isNavigationBarHidden
                                           animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.inshortsView reloadData];
  [self showNavigationBarIfNoContentAvailable];
}

#pragma mark - UANewsCardViewDelegate

- (void)newsCardViewDidPressReadMore:(UANewsCardView *)newsCardView {
  NSURL *sourceURL = [NSURL URLWithString:newsCardView.newsItem.sourceURLString];
  SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:sourceURL];
  [self.navigationController presentViewController:safariViewController animated:YES completion:nil];
}

- (void)newsCardViewDidTapTitleView:(UANewsCardView *)newsCardView {
  UANewsItem *newsItem = newsCardView.newsItem;
  [newsItem toggleBookmarkInManagedObjectContext:[UAPersistenceStack sharedInstance].backgroundMOC];
}

@end
