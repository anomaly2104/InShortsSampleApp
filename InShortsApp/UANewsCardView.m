#import "UANewsCardView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UANewsItem+CoreDataClass.h"
#import <DateTools/DateTools.h>
#import "NSString+UAAdditions.h"

#define MoreTitleWithSourceNameAndDate NSLocalizedString(@"more at %@ / %@", @"More title having both source name and date.")
#define MoreTitleWithSourceName NSLocalizedString(@"more at %@", @"More title having source name")
#define MoreTitleWithDate NSLocalizedString(@"%@", @"More title having date.")

@interface UANewsCardView ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *footnoteLabel;

@end

@implementation UANewsCardView

- (void)layoutSubviews {
  [super layoutSubviews];
  self.containerView.frame = self.bounds;
  self.containerView.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)setNewsItem:(UANewsItem *)newsItem {
  _newsItem = newsItem;
  [self setImageURLString:newsItem.imageURLString];
  [self setTitle:newsItem.title];
  [self setContent:newsItem.content];
  [self updateFootnoteLabelWithSourceName:newsItem.sourceName
                                     date:newsItem.createdAt];
  if (newsItem.isBookmarked) {
    self.titleLabel.textColor = [UIColor blueColor];
  } else {
    self.titleLabel.textColor = [UIColor blackColor];
  }
}

- (void)setImageURLString:(NSString *)imageURLString {
  [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                    placeholderImage:nil];
}

- (void)setTitle:(NSString *)title {
  if ([title ua_isStringFittingInOneLineWithMaxSize:self.bounds.size font:self.titleLabel.font]) {
    title = [title ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:2];
  }
  self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content {
  self.contentLabel.text = content;
}

- (void)updateFootnoteLabelWithSourceName:(NSString *)sourceName
                                     date:(NSDate *)date {
  if (sourceName != nil && date != nil) {
    self.footnoteLabel.text = [NSString stringWithFormat:MoreTitleWithSourceNameAndDate, sourceName, date.timeAgoSinceNow];
  } else if (sourceName != nil) {
    self.footnoteLabel.text = [NSString stringWithFormat:MoreTitleWithSourceName, sourceName];
  } else if (date != nil) {
    self.footnoteLabel.text = [NSString stringWithFormat:MoreTitleWithDate, date.timeAgoSinceNow];
  }
}

#pragma mark - Actions

- (IBAction)titleTapped:(id)sender {
  [self.delegate newsCardViewDidTapTitleView:self];
}

- (IBAction)readMorePressed:(id)sender {
  [self.delegate newsCardViewDidPressReadMore:self];
}

@end
