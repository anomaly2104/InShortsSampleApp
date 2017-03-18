#import <UIKit/UIKit.h>

@protocol UAInshortsViewDataSource, UAInshortsViewDelegate;

@interface UAInshortsView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)reloadData;

@property (nonatomic, weak) id<UAInshortsViewDataSource> dataSource;
@property (nonatomic, weak) id<UAInshortsViewDelegate> delegate;
@property (nonatomic) NSInteger numberOfItems;
@property (nonatomic) NSInteger currentItemIndex;

@end

@protocol UAInshortsViewDataSource <NSObject>

- (NSInteger)numberOfItemsInInshortsView:(UAInshortsView *)inshortsView;
- (UIView *)inshortsView:(UAInshortsView *)inshortsView
      viewForItemAtIndex:(NSInteger)index
             reusingView:(UIView *)view;

@end


@protocol UAInshortsViewDelegate <NSObject>

@optional
- (void)inshortsViewCurrentItemIndexDidChange:(UAInshortsView *)inshortsView;
- (void)inshortsView:(UAInshortsView *)inshortsView didSelectItemAtIndex:(NSInteger)index;

@end
