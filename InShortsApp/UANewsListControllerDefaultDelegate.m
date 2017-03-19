#import "UANewsListControllerDefaultDelegate.h"
#import "UANewsFetchManager.h"
#import "UANewsItem+CoreDataClass.h"

@interface UANewsListControllerDefaultDelegate ()

@property (nonatomic) UANewsFetchManager *newsFetchManager;

@end

@implementation UANewsListControllerDefaultDelegate

- (instancetype)init {
  self = [super init];
  if (self) {
    self.newsFetchManager = [[UANewsFetchManager alloc] init];
  }
  return self;
}

- (void)fetchLatestNews {
  [self.newsFetchManager fetchNewsListWithNewsOffset:nil
                                           ascending:YES];
}

#pragma mark - UANewsListControllerDelegate

- (void)newsListControllerDidLoad:(UANewsListController *)newsListController {
  [self fetchLatestNews];
}

- (void)newsListControllerDidScrollToBottom:(UANewsListController *)newsListController
                               lastNewsItem:(UANewsItem *)lastNewsItem {
  [self.newsFetchManager fetchNewsListWithNewsOffset:lastNewsItem.hashID
                                           ascending:YES];
}

- (void)newsListControllerDidPullToRefresh:(UANewsListController *)newsListController {
  [self fetchLatestNews];
}

@end
