#import "UAHomeViewController.h"
#import <TDTChocolate/TDTFoundationAdditions.h>

@interface UAHomeViewController ()

@property (nonatomic) UISearchBar *searchBar;

@end

@implementation UAHomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.searchBar = [[UISearchBar alloc] init];
  self.navigationItem.titleView = self.searchBar;
}

#pragma mark - Segue

- (NSString *)searchText {
  return [self.searchBar.text tdt_stringByTrimmingWhitespaceAndNewlines];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
  if ([identifier isEqualToString:@"UASearch"]) {
    return [[self searchText] tdt_isNonEmpty];
  }
  return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"UAShowBookmarks"]) {
    UANewsListController *booksmarks = segue.destinationViewController;
    booksmarks.predicate = [self predicateForBooksmarks];
  } else if ([segue.identifier isEqualToString:@"UASearch"]) {
    UANewsListController *search = segue.destinationViewController;
    search.predicate = [self predicateForSearch];
  }
}

- (NSPredicate *)predicateForBooksmarks {
  return [NSPredicate predicateWithFormat:@"isBookmarked = 1"];
}

- (NSPredicate *)predicateForSearch {
  return [NSPredicate predicateWithFormat:@"(content CONTAINS[cd] %@) OR (title CONTAINS[cd] %@)",
          [self searchText],
          [self searchText]];
}

@end
