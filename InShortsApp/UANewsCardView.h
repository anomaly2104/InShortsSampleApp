#import <UIKit/UIKit.h>

@interface UANewsCardView : UIView

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) int containerWidth;
@property (nonatomic) int containerHeight;
@property (nonatomic) int containerX;
@property (nonatomic) int containerY;

- (void)setImageURLString:(NSString *)imageURLString;
- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;

@end
