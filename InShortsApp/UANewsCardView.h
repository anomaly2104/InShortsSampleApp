#import <UIKit/UIKit.h>

@class UANewsItem;

@interface UANewsCardView : UIView

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)updateWithNewsItem:(UANewsItem *)newsItem;

@end
