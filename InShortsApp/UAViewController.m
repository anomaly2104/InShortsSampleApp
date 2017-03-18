//
//  UAViewController.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UAViewController.h"
#import "UANewsFetchManager.h"
#import "UAInshortsView.h"
#import "UANewsCardView.h"
#import <CoreData/CoreData.h>
#import "UAPersistenceStack.h"
#import "UANewsItem+CoreDataClass.h"
#import <TDTChocolate/TDTCoreDataAdditions.h>
#import <TDTChocolate/TDTFoundationAdditions.h>
#import "UANewsCardView.h"
#import "UANewsItem+Additions.h"
#import <SVWebViewController/SVWebViewController.h>
#import <SafariServices/SFSafariViewController.h>

@interface UAViewController () <UAInshortsViewDelegate,
UAInshortsViewDataSource,
NSFetchedResultsControllerDelegate,
UANewsCardViewDelegate>

@property (nonatomic) UANewsFetchManager *newsFetchManager;
@property (nonatomic) UAInshortsView *inshortsView;

@property (nonatomic) NSFetchedResultsController *nfrc;

@end

@implementation UAViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.inshortsView = [[UAInshortsView alloc] initWithFrame:self.view.frame];
  self.inshortsView.dataSource = self;
  self.inshortsView.delegate = self;
  [self.view addSubview:self.inshortsView];
  
  [self setupNFRC];
  
  self.newsFetchManager = [[UANewsFetchManager alloc] init];
  [self fetchLatestNews];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)fetchLatestNews {
  [self.newsFetchManager fetchNewsListWithNewsOffset:nil
                                           ascending:YES];
}

- (void)setupNFRC {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[UANewsItem tdt_entityName]];
  fetchRequest.predicate = nil;
  fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                  ascending:NO] ];
  
  self.nfrc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                  managedObjectContext:[UAPersistenceStack sharedInstance].mainMOC
                                                    sectionNameKeyPath:nil
                                                             cacheName:nil];
  self.nfrc.delegate = self;
  [self.nfrc tdt_performFetch];
}

#pragma mark - UAInshortsViewDelegate

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

#pragma mark - UAInshortsViewDataSource

- (void)inshortsViewCurrentItemIndexDidChange:(UAInshortsView *)inshortsView {
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)inshortsView:(UAInshortsView *)inshortsView
didSelectItemAtIndex:(NSInteger)index {
  [self.navigationController setNavigationBarHidden:!self.navigationController.isNavigationBarHidden
                                           animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.inshortsView reloadData];
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
