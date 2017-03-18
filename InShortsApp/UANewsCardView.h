#import <UIKit/UIKit.h>

@class UANewsItem;

@protocol UANewsCardViewDelegate;

@interface UANewsCardView : UIView

@property (nonatomic, weak) id<UANewsCardViewDelegate> delegate;
@property (nonatomic) UANewsItem *newsItem;

@end

@protocol UANewsCardViewDelegate <NSObject>

- (void)newsCardViewDidTapTitleView:(UANewsCardView *)newsCardView;
- (void)newsCardViewDidPressReadMore:(UANewsCardView *)newsCardView;

@end
